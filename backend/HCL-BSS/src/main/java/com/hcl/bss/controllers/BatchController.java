package com.hcl.bss.controllers;

import com.hcl.bss.dto.BatchDto;
import com.hcl.bss.dto.BatchRunLogDto;
import com.hcl.bss.dto.DropDownOutDto;
import com.hcl.bss.dto.FilterRequest;
import com.hcl.bss.schedulers.SubscriptionRenewalScheduler;
import com.hcl.bss.schedulers.SubscriptionScheduler;
import com.hcl.bss.services.BatchLogService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static com.hcl.bss.constants.ApplicationConstants.DATE_FORMAT_DDMMYYYY;

@CrossOrigin(origins = "*")
@RestController
public class BatchController {

	@Autowired
	SubscriptionScheduler subscriptionScheduler;

	@Autowired
	SubscriptionRenewalScheduler subscriptionRenewalScheduler;

	@Autowired
	BatchLogService batchLogService;
	
	@Value("${app.page.size}")
	Integer recordPerPage;
	
	@ApiOperation(value = "Get last subscription batch report error log", response = BatchDto.class)
	@RequestMapping(value = "/batch/lastBatchRunLog/{pageNo}", produces = {
	  "application/json"
	 }, method = RequestMethod.GET)
	 public ResponseEntity<BatchDto> getLastBatchRunLog(@PathVariable("pageNo") String pageNo) {
	
	  BatchDto orderDto = new BatchDto();
	  Integer pageNumber = Integer.valueOf(pageNo);
	  
      Pageable reqCount = PageRequest.of(pageNumber, recordPerPage);
	  
	  Calendar cal = Calendar.getInstance();
	  cal.add(Calendar.DATE, -1);
	  try{
		  orderDto.setFailed(batchLogService.findLastFailCount(com.hcl.bss.constants.ApplicationConstants.FAIL_STATUS));
		  orderDto.setSuccess(batchLogService.findLastSuccessCount(cal.getTime(),com.hcl.bss.constants.ApplicationConstants.STATUS_SUCCESS));
		  List <BatchRunLogDto> responseList = batchLogService.findLastBatchOrders(reqCount, cal.getTime(), com.hcl.bss.constants.ApplicationConstants.FAIL_STATUS);
		  Integer pageNum = reqCount.getPageNumber()+1;
		  Long noOfTotalRecords = batchLogService.findTotalCountByDate(cal.getTime(),null,com.hcl.bss.constants.ApplicationConstants.FAIL_STATUS);
		  if(noOfTotalRecords>pageNum*reqCount.getPageSize())
			  orderDto.setLastPage(false);
		  else
			  orderDto.setLastPage(true);
		  Long totalPages = noOfTotalRecords/reqCount.getPageSize();
		  if(noOfTotalRecords%reqCount.getPageSize() != 0) {
			  totalPages = totalPages+1;
		  }
		  orderDto.setTotalPages(totalPages);
		  orderDto.setBatchRunLogDtoList(responseList);
		  cal.clear();
		  if(responseList.isEmpty()) {
			  orderDto.setMessage("There are no Failed Subscription");
			  return new ResponseEntity<>(orderDto, HttpStatus.OK);
	  		}else {
	  		return new ResponseEntity<>(orderDto, HttpStatus.OK);
	  		}
	  }
	  catch (Exception e) {
			// TODO: handle exception
			  return new ResponseEntity<BatchDto>(orderDto, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	  
}
	
	@ApiOperation(value = "Get filtered subscription batch report log", response = BatchDto.class)
	 @RequestMapping(value = "/batch/batchRunLog", produces = {
	  "application/json"
	 }, method = RequestMethod.POST)
	 public ResponseEntity<BatchDto> getCustomBatchRunLog(@RequestBody FilterRequest filterRequest) {

	  BatchDto orderDto = new BatchDto();
	  Integer pageNumber = Integer.valueOf(filterRequest.getPageNo());
	  
      Pageable reqCount = PageRequest.of(pageNumber, recordPerPage);
	  try{
		  Date startDate = null;
		  Date endDate = null;
		  try{
			  if(filterRequest.getStartDate()!=null && filterRequest.getEndDate()!=null) {
				  startDate = new SimpleDateFormat(DATE_FORMAT_DDMMYYYY).parse(filterRequest.getStartDate());
				  endDate = new SimpleDateFormat(DATE_FORMAT_DDMMYYYY).parse(filterRequest.getEndDate());
			  }
			  else
				  startDate = new SimpleDateFormat(DATE_FORMAT_DDMMYYYY).parse(filterRequest.getStartDate());			 
		  }
		  catch (Exception e) {
			  e.printStackTrace();
		  }
		  orderDto.setSuccess(batchLogService.findSuccessCountByDate(startDate, endDate, com.hcl.bss.constants.ApplicationConstants.STATUS_SUCCESS));
		  orderDto.setFailed(batchLogService.findFailCountByDate(startDate, endDate, com.hcl.bss.constants.ApplicationConstants.FAIL_STATUS));
		  List <BatchRunLogDto> responseList = batchLogService.findBatchOrders(reqCount, startDate, endDate,filterRequest.getStatus());
		  Integer pageNo = reqCount.getPageNumber()+1;
		  Long noOfTotalRecords = batchLogService.findTotalCountByDate(startDate,endDate,filterRequest.getStatus());
		  if(noOfTotalRecords>pageNo*reqCount.getPageSize())
			  orderDto.setLastPage(false);
		  else
			  orderDto.setLastPage(true);
		  Long totalPages = noOfTotalRecords/reqCount.getPageSize();
		  if(noOfTotalRecords%reqCount.getPageSize() != 0) {
			  totalPages = totalPages+1;
		  }
		  orderDto.setTotalPages(totalPages);
		  orderDto.setBatchRunLogDtoList(responseList);
		  if(responseList.isEmpty()) {
			  orderDto.setMessage("No Record Found");
			  return new ResponseEntity<>(orderDto,HttpStatus.OK);
		  }else {
			  return new ResponseEntity<>(orderDto,HttpStatus.OK);  
		  }
	  }
	  catch (Exception e) {
			// TODO: handle exception
			  return new ResponseEntity<BatchDto>(orderDto, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@ApiOperation(value = "Get Dropdown Data", response = DropDownOutDto.class)
	@RequestMapping(value = "/batch/getBatchDropDown",method = RequestMethod.POST)
	public ResponseEntity<DropDownOutDto> dropDownData(@RequestParam String statusId) {
		DropDownOutDto dropDownOutDto = new DropDownOutDto();
		try {
			List<String> dropDownList = batchLogService.getDropDownData(statusId);
			if(dropDownList!=null && !dropDownList.isEmpty()) {
				dropDownOutDto.setMessage("Drop Down Fetched Successfully");
				dropDownOutDto.setResponseCode(HttpStatus.OK.value());
				dropDownOutDto.setSuccess(true);
				dropDownOutDto.setDropDownList(dropDownList);
				return new ResponseEntity<DropDownOutDto>(dropDownOutDto,HttpStatus.OK);
			}		
			else {
				dropDownOutDto.setMessage("Drop Down values not found in Database");
				dropDownOutDto.setResponseCode(HttpStatus.NOT_FOUND.value());
				dropDownOutDto.setSuccess(false);
				return new ResponseEntity<DropDownOutDto>(dropDownOutDto,HttpStatus.NOT_FOUND);
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			dropDownOutDto.setMessage(e.getMessage());
			dropDownOutDto.setResponseCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
			dropDownOutDto.setSuccess(false);
			return new ResponseEntity<DropDownOutDto>(dropDownOutDto,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}


	@ApiOperation(value = "Execute Schedulers", response = String.class)
	@RequestMapping(value = "/batch/executeSchedulers",
			produces = { "application/json" }, method = RequestMethod.GET)
	public boolean executeScheduler(@RequestParam(value = "schedulerId", required = true) int schedulerId) {

		boolean status = false;
		switch (schedulerId){
			case 1:
				subscriptionScheduler.runSubscriptionBatch();
				status = true;
			break;
			case 2:
				subscriptionRenewalScheduler.runAutorenewSubscriptionsScheduler();
				status = true;
			break;
		}
		return status;
	}
}
