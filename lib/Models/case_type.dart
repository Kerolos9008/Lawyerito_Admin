class CaseType {

  String caseTypeName;

  static List<CaseType> getCaseTypes() {
    List<CaseType> caseTypes = List<CaseType>();
    CaseType caseTypeModel = CaseType();

    caseTypeModel.caseTypeName = 'Bankruptcy';
    caseTypes.add(caseTypeModel); 

    caseTypeModel = new CaseType();

    caseTypeModel.caseTypeName = 'Business Law';
    caseTypes.add(caseTypeModel);

    caseTypeModel = new CaseType();
    caseTypeModel.caseTypeName = 'Criminal Defense';
    caseTypes.add(caseTypeModel);

    caseTypeModel = new CaseType();
    caseTypeModel.caseTypeName = 'Divorce';
    caseTypes.add(caseTypeModel);
    
    caseTypeModel = new CaseType();
    caseTypeModel.caseTypeName = 'Government';
    caseTypes.add(caseTypeModel);

    caseTypeModel = new CaseType();
    caseTypeModel.caseTypeName = 'Health Care & Social';
    caseTypes.add(caseTypeModel);

    caseTypeModel = new CaseType();
    caseTypeModel.caseTypeName = 'Real Estate';
    caseTypes.add(caseTypeModel);

    return caseTypes;
  }
}