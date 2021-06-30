public class RollupClass {

//Método para atualização e sumarização de um campo do objeto AccountTeamMember em um campo do objeto Account
  public static void RollupMethod (List<AccountTeamMember> oldTrigger, List<AccountTeamMember> newTrigger)
  {
    
        List<Id> accId =  New List<Id>();
        
        //Caso delete
        if(oldTrigger != null && newTrigger == null)
        {
            for(AccountTeamMember accTeam : oldTrigger)
            {
                accId.add(accTeam.AccountId);
            }
        }
		//Caso update ou insert
        else
        {
            for(AccountTeamMember accTeam : newTrigger)
            {
                accId.add(accTeam.AccountId);
            }
        }
        
        List<Account> updateFieldAcc = new List<Account>();
        List<Account> accList = [SELECT Id, field_to_recieve_rollup__c from Account WHERE Id in : accId LIMIT 1];
        List<AccountTeamMember> accTeam = [SELECT field_to_rollup__c, accountid 
                                               FROM AccountTeamMember 
                                               WHERE isDeleted = false 
                                               AND AccountId in : accId 
                                               ORDER BY field_to_rollup__c 
                                               DESC NULLS LAST LIMIT 1];
	  if(accTeam.size() > 0)
	  {
		for(Account acc : accList)
		{
		    acc.field_to_recieve_rollup__c = accTeam[0].field_to_rollup__c;
		    updateFieldAcc.add(acc);
		}
		update(updateFieldAcc);
	  }
    }
}
