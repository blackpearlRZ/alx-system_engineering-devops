# Postmortem: When the Load Balancer Went Rogue


## Issue Summary
On August 14, 2024, at 12:30 PM UTC, the checkout process on our e-commerce website, ShopNow, became unresponsive due to a misconfiguration in the payment gateway integration. This outage prevented users from completing their purchases, affecting approximately 70% of active users during the peak shopping period.

## Timeline
12:30 PM: An automated monitoring alert detected a sudden drop in successful checkout transactions. The alert was triggered by our application performance monitoring tool, New Relic.

12:35 PM: The on-call engineer, using Datadog, observed a spike in error rates related to the Stripe API calls, indicating potential issues with payment processing.

12:45 PM: Initial investigation focused on potential network issues between our servers (hosted on AWS) and Stripe’s API endpoints, but the network appeared stable with no packet loss or latency issues.

1:00 PM: The team reviewed the recent deployment logs in Jenkins and noticed a configuration update to the Stripe API keys and settings that coincided with the start of the issue.

1:15 PM: Further analysis revealed that the update had altered the way our backend (running on Node.js) handled specific credit card transactions, particularly those involving 3D Secure authentication.

1:30 PM: The team initiated a rollback of the Stripe configuration to the previous stable version using Terraform scripts, reverting all changes made during the deployment.

1:35 PM: The rollback was completed successfully, and the error rates in Datadog began to decline, indicating that the issue was resolved.

1:40 PM: The team confirmed through multiple test transactions that the checkout process was functioning correctly, and the system was fully restored for all users.

## Root Cause and Resolution
Root Cause: The outage was caused by a misconfiguration in the Stripe payment gateway integration. During a routine update, changes were made to the Stripe API keys and settings that were incompatible with our Node.js backend’s handling of 3D Secure credit card transactions. This misconfiguration led to failures in processing payments for a subset of users.

Resolution: The issue was resolved by rolling back the Stripe configuration to the previous stable version using our infrastructure as code (IaC) tools. The rollback corrected the API settings, restoring compatibility between the Stripe gateway and our backend services. After the rollback, extensive testing was conducted to ensure that all payment methods were functioning correctly, and no further issues were detected.

## Corrective and Preventative Measures

1.Improve Configuration Review Process

2.Expand Test Coverage

3.Enhanced Monitoring

4.Documentation and Training
