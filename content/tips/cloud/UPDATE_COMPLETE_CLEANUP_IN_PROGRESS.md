---
title: UPDATE_COMPLETE_CLEANUP_IN_PROGRESS
date: 2021-10-18
description: Stuck with UPDATE_COMPLETE_CLEANUP_IN_PROGRESS
---


From thease notes, I understand that your stack is stuck in “UPDATE_COMPLETE_CLEANUP_IN_PROGRESS” state and it is not changing the state. Hence you need guidance on how to move further. Please correct me if I misunderstood the case.
m the case notes, I understand that your stack is stuck in “UPDATE_COMPLETE_CLEANUP_IN_PROGRESS” state and it is not changing the state. Hence you need guidance on how to move further. Please correct me if I misunderstood the case.

I have investigated this, please allow me to share my findings.

To begin with, I have checked you stack “invokeA” status and found that at this moment it is in “UPDATE_COMPLETE” state. Hence, I believe that the issue is resolved. However, I have checked your stack events and found that the stack was trying to delete a resource “AWS::Lambda::Permission” with logical ID “HelloWorldFunctionHelloWorldPermissionProd”, but it was failing.

    Error-
    ————
    2021-10-15T04:45:04.662Z.    AWS::Lambda::Permission	HelloWorldFunctionHelloWorldPermissionProdDELETE_FAILEDAnAn error occurred and the request cannot be processed. (Service: AWSLambda; Status Code: 500; Error Code: ServiceException; Request ID: 6882bb32-e76d-4b7c-9b11-4a1906324f55; Proxy: null)

    Also, I have checked that the time it took for your stack to transition between “UPDATE_COMPLETE_CLEANUP_IN_PROGRESS” to “UPDATE_COMPLETE” is around two hours.
    Stack transition-
    ————————
    2021-10-15T04:08:54.904Z     AWS::CloudFormation::Stack		invokeA  UPDATE_COMPLETE_CLEANUP_IN_PROGRESS
    .
    .
    2021-10-15T06:03:48.019Z      AWS::CloudFormation::Stack	invokeA  UPDATE_COMPLETE          
    ——————————

Now, please allow me to explain why it took 2 hours to change the state of stack, whenever CloudFormation starts removing a resource, it will attempt to delete a resource three times before skipping the resource and continuing the cleanup process ie. when a resource fails to delete for the first time, then CloudFormation will again try to remove it 2 more times and if that also fails, it will skip that resource. Hence, it took almost 2 hours in this process.
For more information regarding this issue, please check the document[1] and [2].

I hope above information have answered your query.

If you have any other queries, please write back to me, I will be more than happy to help.


I have investigated this, please allow me to share my findings.

To begin with, I have checked you stack “invokeA” status and found that at this moment it is in “UPDATE_COMPLETE” state. Hence, I believe that the issue is resolved. However, I have checked your stack events and found that the stack was trying to delete a resource “AWS::Lambda::Permission” with logical ID “HelloWorldFunctionHelloWorldPermissionProd”, but it was failing.

    Error-
    ————
    2021-10-15T04:45:04.662Z.    AWS::Lambda::Permission	HelloWorldFunctionHelloWorldPermissionProdDELETE_FAILEDAn error occurred and the request cannot be processed. (Service: AWSLambda; Status Code: 500; Error Code: ServiceException; Request ID: 6882bb32-e76d-4b7c-9b11-4a1906324f55; Proxy: null)

    Also, I have checked that the time it took for your stack to transition between “UPDATE_COMPLETE_CLEANUP_IN_PROGRESS” to “UPDATE_COMPLETE” is around two hours.
    Stack transition-
    ————————
    2021-10-15T04:08:54.904Z     AWS::CloudFormation::Stack		invokeA  UPDATE_COMPLETE_CLEANUP_IN_PROGRESS
    .
    .
    2021-10-15T06:03:48.019Z      AWS::CloudFormation::Stack	invokeA  UPDATE_COMPLETE          
    ——————————

Now, please allow me to explain why it took 2 hours to change the state of stack, whenever CloudFormation starts removing a resource, it will attempt to delete a resource three times before skipping the resource and continuing the cleanup process ie. when a resource fails to delete for the first time, then CloudFormation will again try to remove it 2 more times and if that also fails, it will skip that resource. Hence, it took almost 2 hours in this process.
For more information regarding this issue, please check the document[1] and [2].

I hope above information have answered your query.

If you have any other queries, please write back to me, I will be more than happy to help.

