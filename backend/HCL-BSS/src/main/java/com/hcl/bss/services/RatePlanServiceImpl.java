package com.hcl.bss.services;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.hcl.bss.domain.RatePlan;
import com.hcl.bss.domain.RatePlanVolume;
import com.hcl.bss.domain.UOM;
import com.hcl.bss.dto.ProductDto;
import com.hcl.bss.dto.RatePlanDto;
import com.hcl.bss.dto.RatePlanFilterReqDto;
import com.hcl.bss.dto.RatePlanVolumeDto;
import com.hcl.bss.dto.ResponseDto;
import com.hcl.bss.exceptions.CustomGlobalException;
import com.hcl.bss.repository.AppConstantRepository;
import com.hcl.bss.repository.CurrencyMasterRepository;
import com.hcl.bss.repository.OrderRepository;
import com.hcl.bss.repository.RatePlanRepository;
import com.hcl.bss.repository.RatePlanVolumeRepository;
import com.hcl.bss.repository.SubscriptionRatePlanRepository;
import com.hcl.bss.repository.UOMRepository;
import com.hcl.bss.repository.specification.OrderSpecification;
import com.hcl.bss.repository.specification.RatePlanSpecification;
import com.hcl.bss.repository.specification.SubscriptionRatePlanSpecification;
@Service
@Transactional
public class RatePlanServiceImpl implements RatePlanService {

	@Autowired
	RatePlanRepository ratePlanRepository;
	@Autowired
	CurrencyMasterRepository currencyMasterRepository;
	@Autowired
	UOMRepository uomRepository;
	@Autowired
	AppConstantRepository appConstantRepository;
	@Autowired
	RatePlanVolumeRepository ratePlanVolumeRepository;
	@Autowired
	SubscriptionRatePlanRepository subscriptionRatePlanRepository;
	@Autowired
	OrderRepository orderRepository;
	
	@Override
	public ResponseDto addRatePlan(RatePlanDto ratePlanDto) {
		
		ResponseDto responseDto = new ResponseDto();
		try {
			ratePlanRepository.save(convertRatePlanDtoToEntity(ratePlanDto));
			responseDto.setResponseCode(HttpStatus.OK.value());
			responseDto.setResponseStatus("Success");
			responseDto.setMessage("Plan Added Successfully");
			return responseDto;
		}catch (Exception e) {
			// TODO: handle exception
			responseDto.setResponseCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
			responseDto.setResponseStatus("Fail");
			responseDto.setMessage("Plan Could not be added");
			return responseDto;
		}
		
	}
	
	@Override
	public ResponseDto updateRatePlan(RatePlanDto ratePlanDto) {
		ResponseDto responseDto = new ResponseDto();
		RatePlan ratePlan = new RatePlan();
		if(ratePlanDto.getUidpk()!=null) {
			ratePlan = ratePlanRepository.findById(ratePlanDto.getUidpk()).get();
			if(ratePlan!=null) {
				ratePlan.setRatePlanDescription(ratePlanDto.getName());
				ratePlan.setRatePlanId(ratePlanDto.getRatePlanId());
				ratePlan.setBillingCycleTerm(ratePlanDto.getBillingCycleTerm());
				ratePlan.setBillingFrequency(ratePlanDto.getBillEvery());
				if(ratePlan.getPricingScheme().equalsIgnoreCase("UNIT"))
					ratePlan.setPrice(ratePlanDto.getPrice());
				else if(ratePlan.getPricingScheme().equalsIgnoreCase("VOLUME")) {
					ratePlan.setRatePlanVolume(convertRatePlanVolumeDtoToEntityForUpdate(ratePlanDto.getRatePlanVolumeDtoList(),ratePlan));
				}
				ratePlan.setExpireAfter(ratePlanDto.getExpireAfter());
				ratePlan.setSetUpFee(ratePlanDto.getSetUpFee());
				ratePlan.setFreeTrail(ratePlanDto.getFreeTrail());
				ratePlanRepository.save(ratePlan);
				responseDto.setResponseCode(200);
				responseDto.setResponseStatus("Okay");
				responseDto.setMessage("Rate Plan Updated Successfully");
				return responseDto;
			}
			else
				throw new CustomGlobalException(100, "Rate Plan not found to update");
		}
		else
			throw new CustomGlobalException(100, "Invalid rate plan to update");
	}
	
	@Override
	public List<RatePlanDto> getRatePlans(Pageable reqCount,RatePlanFilterReqDto filterReq) {
		List<RatePlan> ratePlanList = new ArrayList<>();
		Page<RatePlan> result = ratePlanRepository.findAll(Specification.where(RatePlanSpecification.hasName(filterReq.getPlanName()))
				.and(RatePlanSpecification.hasPlanCode(filterReq.getPlanCode()))
				.and(RatePlanSpecification.hasBillCycleTerm(filterReq.getBillCycleTerm()))
				.and(RatePlanSpecification.hasBillFreq(filterReq.getBillFreq()))
				.and(RatePlanSpecification.hasStatus(filterReq.getStatus()))
				.and(RatePlanSpecification.hasType(filterReq.getPlanType())), reqCount);
		if(result!=null){	
			ratePlanList = result.getContent();
			return convertRatePlanEntityToDto(ratePlanList);
		}
		return null;
	}
	
	private List<RatePlanDto> convertRatePlanEntityToDto(List<RatePlan> ratePlanList) {
		List<RatePlanDto> ratePlanDtoList = new ArrayList<RatePlanDto>();
		List<RatePlanVolume> ratePlanVolumeList = new ArrayList<RatePlanVolume>();
		for(RatePlan rplan : ratePlanList) {

			RatePlanDto rpDto = new RatePlanDto();
			rpDto.setRatePlanId(rplan.getRatePlanId());
			rpDto.setName(rplan.getRatePlanDescription());
			rpDto.setBillEvery(rplan.getBillingFrequency());
			rpDto.setPricingScheme(rplan.getPricingScheme());
			rpDto.setExpireAfter(rplan.getExpireAfter());
			if("VOLUME".equalsIgnoreCase(rplan.getPricingScheme())) {
				
				ratePlanVolumeList = ratePlanVolumeRepository.findByRatePlan(rplan.getId());
				rpDto.setRatePlanVolumeDtoList(convertRatePlanVolumeEntityToDto(ratePlanVolumeList));
			}
			else
				rpDto.setPrice(rplan.getPrice());
			rpDto.setUnitOfMesureId(rplan.getUom().getUnitOfMeasure());
			rpDto.setBillingCycleTerm(rplan.getBillingCycleTerm());
			rpDto.setSetUpFee(rplan.getSetUpFee());
			rpDto.setFreeTrail(rplan.getFreeTrail());
			if(rplan.getIsActive() == 0) {
				rpDto.setIsActive("Inactive");
			}
			else {
				rpDto.setIsActive("Active");
			}
			rpDto.setUidpk(rplan.getId());
			if(subscriptionRatePlanRepository.count(Specification.where(SubscriptionRatePlanSpecification.hasRatePlanUID(rplan.getId())))!=0 || orderRepository.count(Specification.where(OrderSpecification.hasRatePlanUID(rplan.getId())))!=0) {
				rpDto.setTransactionFlag(true);
			}
			else
				rpDto.setTransactionFlag(false);
			ratePlanDtoList.add(rpDto);
		}
		return ratePlanDtoList;
	}
	
private List<RatePlanVolumeDto> convertRatePlanVolumeEntityToDto(List<RatePlanVolume> ratePlanVolumeList) {

	List<RatePlanVolumeDto> ratePlanVolumeDtoList = new ArrayList<RatePlanVolumeDto>();
	ratePlanVolumeList.forEach(ratePlanVolumeDto->{
		RatePlanVolumeDto ratePlanVolume = new RatePlanVolumeDto();
		ratePlanVolume.setId(ratePlanVolumeDto.getId());
		ratePlanVolume.setStartQty(ratePlanVolumeDto.getStartQty());
		ratePlanVolume.setEndQty(ratePlanVolumeDto.getEndQty());
		ratePlanVolume.setPrice(ratePlanVolumeDto.getPrice());
		ratePlanVolumeDtoList.add(ratePlanVolume);
	});
	return ratePlanVolumeDtoList;
	}



private RatePlan convertRatePlanDtoToEntity(RatePlanDto ratePlanDto) {
		
		RatePlan ratePlan = new RatePlan();
		ratePlan.setRatePlanDescription(ratePlanDto.getName());
		ratePlan.setRatePlanId(ratePlanDto.getRatePlanId());
		ratePlan.setBillingCycleTerm(ratePlanDto.getBillingCycleTerm());
		ratePlan.setBillingFrequency(ratePlanDto.getBillEvery());
		ratePlan.setPricingScheme(ratePlanDto.getPricingScheme());
		ratePlan.setFreeTrail(ratePlanDto.getFreeTrail());
		ratePlan.setSetUpFee(ratePlanDto.getSetUpFee());
		//To be decide
		if(ratePlanDto.getCurrencyCode()!=null)
			ratePlan.setCurrency(currencyMasterRepository.getOne(ratePlanDto.getCurrencyCode()));
		if(ratePlanDto.getPricingScheme().equals("UNIT")) {
			ratePlan.setPrice(ratePlanDto.getPrice());
		}
		else if(ratePlanDto.getPricingScheme().equals("VOLUME")) {
//			ratePlan.setPrice();
			ratePlan.setRatePlanVolume(convertRatePlanVolumeDtoToEntity(ratePlanDto.getRatePlanVolumeDtoList(), ratePlan));
		}
		
		if(uomRepository.getOne(ratePlanDto.getUnitOfMesureId())!=null)
		ratePlan.setUom(uomRepository.getOne(ratePlanDto.getUnitOfMesureId()));
		
		
		if(ratePlanDto.getIsActive().equals("INACTIVE"))
			ratePlan.setIsActive(0);
		else
			ratePlan.setIsActive(1);

		if(ratePlanDto.getExpireAfter()!=BigDecimal.valueOf(9999) && ratePlanDto.getExpireAfter()!=null)
			ratePlan.setExpireAfter(ratePlanDto.getExpireAfter());
		else
			ratePlan.setExpireAfter(BigDecimal.valueOf(9999));
		
		return ratePlan;
	}

	private List<RatePlanVolume> convertRatePlanVolumeDtoToEntity(List<RatePlanVolumeDto> ratePlanVolumeDtoList, RatePlan ratePlan){
	
		List<RatePlanVolume> ratePlanVolumeList = new ArrayList<RatePlanVolume>();
		ratePlanVolumeDtoList.forEach(ratePlanVolumeDto->{
			RatePlanVolume ratePlanVolume = new RatePlanVolume();
			ratePlanVolume.setStartQty(ratePlanVolumeDto.getStartQty());
			ratePlanVolume.setEndQty(ratePlanVolumeDto.getEndQty());
			ratePlanVolume.setPrice(ratePlanVolumeDto.getPrice());
			ratePlanVolume.setRatePlanUid(ratePlan);
			ratePlanVolumeList.add(ratePlanVolume);
		});
		return ratePlanVolumeList;
	}
	
	private List<RatePlanVolume> convertRatePlanVolumeDtoToEntityForUpdate(List<RatePlanVolumeDto> ratePlanVolumeDtoList, RatePlan ratePlan){
		
		List<RatePlanVolume> ratePlanVolumeList = ratePlan.getRatePlanVolume();
		ratePlanVolumeDtoList.forEach(ratePlanVolumeDto->{
			ratePlanVolumeList.forEach(ratePlanVolume->{
				if(ratePlanVolumeDto.getId()==ratePlanVolume.getId()) {
					ratePlanVolume.setStartQty(ratePlanVolumeDto.getStartQty());
					ratePlanVolume.setEndQty(ratePlanVolumeDto.getEndQty());
					ratePlanVolume.setPrice(ratePlanVolumeDto.getPrice());
					ratePlanVolume.setRatePlanUid(ratePlan);
				}
			});
		});
		return ratePlanVolumeList;
	}
	
	@Override
	public List<String> getCurrency() {
		
		List<String> currencyList = new ArrayList<String>();
		try{
			currencyList = currencyMasterRepository.getCurrency();
			return currencyList;
		}catch (Exception e) {
			// TODO: handle exception
			currencyList.add("Currency code could not be fetch");
			return currencyList;
		}
	}
	
	@Override
	public Iterable<UOM> getUom() {
		
		return uomRepository.findAll();
	}



	@Override
	public List<String> getDropDownData(String statusId) {
		// TODO Auto-generated method stub
		return appConstantRepository.findByAppConstantCode(statusId);
	}
	
	@Override
	public Long getTotalNumberOfRatePlan(RatePlanFilterReqDto filterReq) {
		return ratePlanRepository.count(Specification.where(RatePlanSpecification.hasName(filterReq.getPlanName()))
				.and(RatePlanSpecification.hasPlanCode(filterReq.getPlanCode()))
				.and(RatePlanSpecification.hasBillCycleTerm(filterReq.getBillCycleTerm()))
				.and(RatePlanSpecification.hasBillFreq(filterReq.getBillFreq()))
				.and(RatePlanSpecification.hasStatus(filterReq.getStatus()))
				.and(RatePlanSpecification.hasType(filterReq.getPlanType())));
	}
}
