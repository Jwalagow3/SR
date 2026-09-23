CREATE OR REPLACE TRIGGER LXBO_4F70A3B1_UPSERT_DEL_TRG
AFTER UPDATE OR INSERT OR DELETE
ON LXBO_4F70A3B1
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
  v_count number :=0;
  v_type varchar2(128 byte);
  v_state varchar2(128 byte);
begin
  if (:new.lxflags <> -1)
  then
    select count(1) into v_count 
    from MXBUSTYPE M1, MXSTATEREQ M2
    where m1.mxname in ('ArtiosCAD Component',
'pgArtwork',
'pgPKGConsumerProposition',
'pgConsumerUnitPart',
'pgPKGProductReadiness',
'pgCustomerUnitPart',
'pgPKGDIPlatform',
'External Material',
'Finished Product Part',
'pgFinishedProduct',
'pgFormulatedProduct',
'Formula Technical Specification',
'Formulation Part',
'pgPKGDevelopmentOther',
'pgIllustration',
'pgInnerPackUnitPart',
'pgIPMDocument',
'pgRawMaterial',
'pgPLIStudyType',
'pgMasterProductPart',
'Packaging Assembly Part',
'Packaging Material Part',
'pgPackingMaterial',
'pgPackingInstructions',
'pgPackingSubassembly',
'pgAncillaryPackagingMaterialPart',
'pgAncillaryRawMaterialPart',
'pgApprovedSupplierList',
'Assembled Product Part',
'pgAssembledProductPart',
'pgAuthorizedConfigurationStandard',
'pgAuthorizedTemporarySpecification',
'pgBaseFormula',
'pgCompetitiveProductPart',
'pgConsumerDesignBasis',
'pgDeviceProductPart',
'pgFabricatedPart',
'pgIntermediateProductPart',
'pgIPMUniversalDocument',
'pgLaboratoryIndexSpecification',
'pgMakingInstructions',
'pgMasterConsumerUnitPart',
'pgMasterCustomerUnitPart',
'pgMasterFinishedProduct',
'pgMasterInnerPackUnitPart',
'pgMasterPackagingAssemblyPart',
'pgMasterPackagingMaterialPart',
'pgMasterPackingMaterial',
'pgMasterRawMaterial',
'pgMasterRawMaterialPart',
'pgOnlinePrintingPart',
'pgProcessStandard',
'pgPromotionalItemPart',
'pgSmartLabel',
'POA',
'pgPOADocument',
'Qualification',
'pgQualitySpecification',
'Raw Material',
'pgRawMaterialPlantInstruction',
'pgAAA_RTA_Generic_Document',
'Software Build',
'pgSoftwarePart',
'pgStabilityOther',
'pgPKGOutofSpec',
'pgPKGStabilityProtocol',
'pgPKGStabilityReport',
'pgStackingPattern',
'pgStandardOperatingProcedure',
'pgPKGStudyProtocol',
'Supplier Equivalent Part',
'pgSupplierInformationSheet',
'pgPKGTechnicalRationale',
'Test Method Specification',
'pgPKGTranslationFile',
'Transport Unit Part',
'pgTransportUnitPart',
'pgValidationOther',
'pgPKGValidationProtocol',
'pgPKGValidationReport',
'pgIPMEBPSummary',
'Consumer Unit Part',
'Customer Unit Part',
'pgSignupForm',
'Person',
'pgStructuredATS',
'Company',
'Plant',
'pgPackagingMinimizationReport')
and m2.mxname in ('Release','Obsolete','Approved','Qualified','Frozen','Active','Inactive','Deactive','Pending','Accepted','Rejected','Complete','Exists') 
    and m2.mxoid=:new.LXSTATE
    and m1.MXOID=:new.LXTYPE ;
    if v_count <> 0
    then
      select MXNAME into v_type from MXBUSTYPE where MXOID=:new.LXTYPE;
      select MXNAME into v_state from MXSTATEREQ where MXOID=:new.LXSTATE;
      insert into sr_monitor
        values (v_type,:new.lxname,:new.lxrev,v_state,:new.LXMODDATE,sysdate + 1/(24*60));
    end if;
  end if;
end;
/

