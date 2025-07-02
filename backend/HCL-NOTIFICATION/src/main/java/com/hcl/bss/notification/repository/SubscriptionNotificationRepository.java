package com.hcl.bss.notification.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.hcl.bss.notification.domain.SubscriptionNotification;

/**
 * @author ranjankumar.y
 *
 */
public interface SubscriptionNotificationRepository extends JpaRepository<SubscriptionNotification, Long>{
	 public SubscriptionNotification findBySubscriptionId(String name);
}
