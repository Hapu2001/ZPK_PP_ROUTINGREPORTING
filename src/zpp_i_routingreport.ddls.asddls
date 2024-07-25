@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Routing Reporting'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define view entity ZPP_I_ROUTINGREPORT
    with parameters 
    @Environment.systemField:#SYSTEM_DATE
    @EndUserText.label: 'Key date'
    KeyDate : sydate
as select from I_MfgBOOOperationChangeState   as MFG_STATE
    left outer join I_MfgBOOMaterialAssignment as MFG_ASS on MFG_ASS.Plant                   = MFG_STATE.Plant
                                                        and MFG_ASS.BillOfOperationsType    = MFG_STATE.BillOfOperationsType
                                                        and MFG_ASS.BillOfOperationsGroup   = MFG_STATE.BillOfOperationsGroup
                                                        and MFG_ASS.BillOfOperationsVariant = MFG_STATE.BillOfOperationsVariant
    
    inner join I_WorkCenter                 as WC        on WC.WorkCenterInternalID         = MFG_STATE.WorkCenterInternalID
                                                        and WC.WorkCenterTypeCode           = MFG_STATE.WorkCenterTypeCode
   
    inner join I_Product                    as PRO       on PRO.Product                     = MFG_ASS.Product
    
    inner join I_ProductText                as textPro  on textPro.Product  = PRO.Product
                                                        and textPro.Language = 'E'
    
    left outer join I_MfgBillOfOperationsChgSt   as MFG_ChgSt on MFG_ChgSt.BillOfOperationsType  = MFG_STATE.BillOfOperationsType
                                                        and MFG_ChgSt.BillOfOperationsGroup      = MFG_STATE.BillOfOperationsGroup
                                                        and MFG_ChgSt.BillOfOperationsVariant    = MFG_STATE.BillOfOperationsVariant
//                                                        and MFG_ChgSt.BOOInternalVersionCounter  = MFG_STATE.BOOOpInternalVersionCounter
                                                        
    left outer join I_CostCenterActivityTypeText as Cost_Text1 on Cost_Text1.CostCtrActivityType        = MFG_STATE.CostCtrActivityType1
                                                              and Cost_Text1.Language                   = 'E'   
                                                         
    left outer join I_CostCenterActivityTypeText as Cost_Text2 on Cost_Text2.CostCtrActivityType        = MFG_STATE.CostCtrActivityType2
                                                              and Cost_Text2.Language                   = 'E'
                                                     
    left outer join I_CostCenterActivityTypeText as Cost_Text3 on Cost_Text3.CostCtrActivityType        = MFG_STATE.CostCtrActivityType3
                                                              and Cost_Text3.Language                   = 'E' 
                                                              
    left outer join I_CostCenterActivityTypeText as Cost_Text4 on Cost_Text4.CostCtrActivityType        = MFG_STATE.CostCtrActivityType4
                                                              and Cost_Text4.Language                   = 'E'
                                                              
    left outer join I_CostCenterActivityTypeText as Cost_Text5 on Cost_Text5.CostCtrActivityType        = MFG_STATE.CostCtrActivityType5
                                                              and Cost_Text5.Language                   = 'E'
                                                              
    left outer join I_CostCenterActivityTypeText as Cost_Text6 on Cost_Text6.CostCtrActivityType        = MFG_STATE.CostCtrActivityType6
                                                              and Cost_Text6.Language                   = 'E'      
             
{   

    @UI: {  lineItem:       [ { position: 20  } ],
            identification: [ { position: 20 } ]  }
    @EndUserText.label: 'Material'
    key MFG_ASS.Product,
    
    @UI: {  lineItem:       [ { position: 40  } ],
            identification: [ { position: 40 } ]  }
    @EndUserText.label: 'Group' 
    key MFG_ASS.BillOfOperationsGroup,
    
    @UI: {  lineItem:       [ { position: 50  } ],
            identification: [ { position: 50 } ]  }
    @EndUserText.label: 'Group Counter' 
    key MFG_ASS.BillOfOperationsVariant,
    
    @UI.hidden: true
    key MFG_STATE.BillOfOperationsSequence,
    
    @UI.hidden: true
    key MFG_STATE.BOOOperationInternalID,
    
    @UI.hidden: true
    key MFG_STATE.BOOSqncOpAssgmtIntVersionCntr,
    
    @UI.hidden: true
    key MFG_STATE.BOOOpInternalVersionCounter,
    
    @UI: {  lineItem:       [ { position: 10  } ],
            identification: [ { position: 10 } ]  }
    @EndUserText.label: 'Plant'
    key MFG_ASS.Plant,
    
    @UI.hidden: true
    key MFG_ASS.BillOfOperationsType,
    
    @UI.hidden: true
    key MFG_ASS.BOOToMaterialInternalID,
    
    @UI: {  lineItem:       [ { position: 30  } ],
            identification: [ { position: 30 } ]  }
    @EndUserText.label: 'Material Description'
    textPro.ProductName,
    
    @UI: {  lineItem:       [ { position: 60  } ],
            identification: [ { position: 60 } ]  }
    @EndUserText.label: 'Description'  
    MFG_ChgSt.BillOfOperationsDesc,
    
    @UI: {  lineItem:       [ { position: 70  } ],
            identification: [ { position: 70 } ]  }
    @EndUserText.label: 'Usage'  
    MFG_ChgSt.BillOfOperationsUsage,
    
    @UI: {  lineItem:       [ { position: 80  } ],
            identification: [ { position: 80 } ]  }
    @EndUserText.label: 'Status'  
    MFG_ChgSt.BillOfOperationsStatus,
    
    @UI: {  lineItem:       [ { position: 90  } ],
            identification: [ { position: 90 } ]  }
    @EndUserText.label: 'Valid From'  
    MFG_ChgSt.ValidityStartDate,
    
    @UI: {  lineItem:       [ { position: 100  } ],
            identification: [ { position: 100 } ]  }
    @EndUserText.label: 'Unit'  
    MFG_ChgSt.BillOfOperationsUnit,
   
    @UI: {  lineItem:       [ { position: 110  } ],
            identification: [ { position: 110 } ]  }
    @EndUserText.label: 'Operation'  
    MFG_STATE.Operation_2,
    
    @UI: {  lineItem:       [ { position: 120  } ],
            identification: [ { position: 120 } ]  }
    @EndUserText.label: 'Operation Description'  
    MFG_STATE.OperationText,
    
    @UI: {  lineItem:       [ { position: 130  } ],
            identification: [ { position: 130 } ]  }
    @EndUserText.label: 'Work Center'  
    WC.WorkCenter,
    
    @UI: {  lineItem:       [ { position: 140  } ],
            identification: [ { position: 140 } ]  }
    @EndUserText.label: 'Control Key'  
    MFG_STATE.OperationControlProfile,
    
    @UI: {  lineItem:       [ { position: 150  } ],
            identification: [ { position: 150 } ]  }
    @EndUserText.label: 'Base Quantity'  
    @Semantics.quantity.unitOfMeasure: 'OperationUnit'
    MFG_STATE.OperationReferenceQuantity,
    
    @UI: {  lineItem:       [ { position: 160  } ],
            identification: [ { position: 160 } ]  }
    @EndUserText.label: 'Operation Unit'  
    MFG_STATE.OperationUnit,
    
    @UI: {  lineItem:       [ { position: 170  } ],
            identification: [ { position: 170 } ]  }
    @EndUserText.label: 'Activity Type 1'  
    MFG_STATE.CostCtrActivityType1,
    
    @UI: {  lineItem:       [ { position: 180  } ],
            identification: [ { position: 180 } ]  }
    @EndUserText.label: 'A T 1 Description'  
    Cost_Text1.CostCtrActivityTypeName as CostCtrActivityTypeName1,
    
    @UI: {  lineItem:       [ { position: 190  } ],
            identification: [ { position: 190 } ]  }
    @EndUserText.label: 'Standard Value 1' 
    @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit1'
    MFG_STATE.StandardWorkQuantity1,
    
    @UI.hidden: true
    MFG_STATE.StandardWorkQuantityUnit1,
    
    @UI: {  lineItem:       [ { position: 200  } ],
            identification: [ { position: 200 } ]  }
    @EndUserText.label: 'Activity Type 2'  
    MFG_STATE.CostCtrActivityType2,
    
    @UI: {  lineItem:       [ { position: 210  } ],
            identification: [ { position: 210 } ]  }
    @EndUserText.label: 'A T 2 Description'  
    Cost_Text2.CostCtrActivityTypeName as CostCtrActivityTypeName2,
    
    @UI: {  lineItem:       [ { position: 220  } ],
            identification: [ { position: 220 } ]  }
    @EndUserText.label: 'Standard Value 2'  
    @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit2'
    MFG_STATE.StandardWorkQuantity2,
    
    @UI.hidden: true
    MFG_STATE.StandardWorkQuantityUnit2,
    
    @UI: {  lineItem:       [ { position: 230  } ],
            identification: [ { position: 230 } ]  }
    @EndUserText.label: 'Activity Type 3'  
    MFG_STATE.CostCtrActivityType3,
    
    @UI: {  lineItem:       [ { position: 240  } ],
            identification: [ { position: 240 } ]  }
    @EndUserText.label: 'A T 3 Description'  
    Cost_Text3.CostCtrActivityTypeName as CostCtrActivityTypeName3,
    
    @UI: {  lineItem:       [ { position: 250  } ],
            identification: [ { position: 250 } ]  }
    @EndUserText.label: 'Standard Value 3'  
    @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit3'
    MFG_STATE.StandardWorkQuantity3,
    
    @UI.hidden: true
    MFG_STATE.StandardWorkQuantityUnit3,
    
    @UI: {  lineItem:       [ { position: 240  } ],
            identification: [ { position: 240 } ]  }
    @EndUserText.label: 'Activity Type 4'  
    MFG_STATE.CostCtrActivityType4,
    
    @UI: {  lineItem:       [ { position: 250  } ],
            identification: [ { position: 250 } ]  }
    @EndUserText.label: 'A T 4 Description'  
    Cost_Text4.CostCtrActivityTypeName as CostCtrActivityTypeName4,
    
    @UI: {  lineItem:       [ { position: 260  } ],
            identification: [ { position: 260 } ]  }
    @EndUserText.label: 'Standard Value 4'  
    @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit4'
    MFG_STATE.StandardWorkQuantity4,
    
    @UI.hidden: true
    MFG_STATE.StandardWorkQuantityUnit4,
    
    @UI: {  lineItem:       [ { position: 270  } ],
            identification: [ { position: 270 } ]  }
    @EndUserText.label: 'Activity Type 5'  
    MFG_STATE.CostCtrActivityType5,
    
    @UI: {  lineItem:       [ { position: 280  } ],
            identification: [ { position: 280 } ]  }
    @EndUserText.label: 'A T 5 Description'  
    Cost_Text5.CostCtrActivityTypeName as CostCtrActivityTypeName5,
    
    @UI: {  lineItem:       [ { position: 290  } ],
            identification: [ { position: 290 } ]  }
    @EndUserText.label: 'Standard Value 5'  
    @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit5'
    MFG_STATE.StandardWorkQuantity5,
    
    @UI.hidden: true
    MFG_STATE.StandardWorkQuantityUnit5,
    
    @UI: {  lineItem:       [ { position: 300  } ],
            identification: [ { position: 300 } ]  }
    @EndUserText.label: 'Activity Type 6'  
    MFG_STATE.CostCtrActivityType6,
    
    @UI: {  lineItem:       [ { position: 310  } ],
            identification: [ { position: 310 } ]  }
    @EndUserText.label: 'A T 6 Description'  
    Cost_Text6.CostCtrActivityTypeName as CostCtrActivityTypeName6,
    
    @UI: {  lineItem:       [ { position: 320  } ],
            identification: [ { position: 320 } ]  }
    @EndUserText.label: 'Standard Value 6'  
    @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit6'
    MFG_STATE.StandardWorkQuantity6,
    
    @UI.hidden: true
    MFG_STATE.StandardWorkQuantityUnit6,
    
    @UI: {  lineItem:       [ { position: 330  } ],
            identification: [ { position: 330 } ]  }
    @EndUserText.label: 'Created On'  
    MFG_ChgSt.CreationDate,
    
    @UI: {  lineItem:       [ { position: 340  } ],
            identification: [ { position: 340 } ]  }
    @EndUserText.label: 'Created By'  
    MFG_ChgSt.CreatedByUser,
    
    @UI: {  lineItem:       [ { position: 350  } ],
            identification: [ { position: 350 } ]  }
    @EndUserText.label: 'Costing'  
    case
        when MFG_STATE.OperationCostingRelevancyType = 'X' then 'Yes'
        else 'No' 
    end as  Costing,
    
    @UI: {  lineItem:       [ { position: 360  } ],
            identification: [ { position: 360 } ]  }
    @EndUserText.label: 'Change number'
    MFG_ChgSt.ChangeNumber,
    
    @UI: {  lineItem:       [ { position: 370  } ],
            identification: [ { position: 370 } ]  }
    @EndUserText.label: 'Changed by'
    MFG_ChgSt.LastChangedByUser,
    
    @UI: {  lineItem:       [ { position: 370  } ],
            identification: [ { position: 370 } ]  }
    @EndUserText.label: 'Changed date'
    MFG_ChgSt.LastChangeDate,
    
    @EndUserText.label: 'Material Type'
    PRO.ProductType, 
    
    @EndUserText.label: 'Material Group'
    PRO.ProductGroup
    
} 
where MFG_STATE.ValidityStartDate <= $parameters.KeyDate
    and MFG_STATE.ValidityEndDate   >= $parameters.KeyDate
    and MFG_STATE.IsDeleted = ''
