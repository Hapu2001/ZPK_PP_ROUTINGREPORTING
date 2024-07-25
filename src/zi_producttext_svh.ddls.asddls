@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@Search.searchable: true
define view entity ZI_ProductText_SVH 
    as select from I_ProductText
{   
//    @Search.defaultSearchElement: true
    key Product,
    key Language,
    
//    @Search.defaultSearchElement: true
    ProductName
}
