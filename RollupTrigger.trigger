trigger RollupTrigger on AccountTeamMember (before insert, before update, after insert, after update,before delete, after delete) 
{
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete) 
    {
      RollupClass.RollupMethod(trigger.old, trigger.new);
    }
}
