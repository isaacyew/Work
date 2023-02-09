function onOpen()
{
  onOpenInstallable('On open - simple trigger');
}

function onOpenInstallable()
{
  onEdit('On open - installable trigger');
}

function onEdit(e)
{
  console.log('Time stamp called');
  addStamping(e); //func call
  // cellProctection(e);
  console.log(e);
}

function addStamping(e)
{
  var currentDate = new Date();
  user = String(user); //data type
  var user = Session.getActiveUser().getEmail(); //variable
  var startRow = 1; //variable
  var targetCol1 = 16; //variable
  var targetCol2 = 14; //variable
  var wS_Tab1 = "PS Escalation Form"; //variable
  var wS_Tab2 = "Resolution Center Tracker"; //variable
  var row = e.range.getRow(); //get mod row and col
  var col = e.range.getColumn(); //get mod row and col

  if(col === targetCol1 && row > startRow && e.source.getActiveSheet().getName() === wS_Tab1)
  {
    console.log('worksheet tab 1');
    if(e.source.getActiveSheet().getRange(row,19).getValue() == "") //endif date created
    {
      e.source.getActiveSheet().getRange(row,19).setValue(currentDate);
      e.source.getActiveSheet().getRange(row,20).setValue(user);
      var protection = e.source.getActiveSheet().getRange(row,19,1,2).protect();
      protection.removeEditors(protection.getEditors());
      if (protection.canDomainEdit())
      {
        protection.setDomainEdit(false);       
      }
    }
  }

  else if(col === targetCol2 && row > startRow && e.source.getActiveSheet().getName() === wS_Tab2)
  {
    console.log('worksheet tab 2');
    if(e.source.getActiveSheet().getRange(row,17).getValue() == "") //endif date created
    {
      e.source.getActiveSheet().getRange(row,17).setValue(currentDate);
      e.source.getActiveSheet().getRange(row,18).setValue(user);
      var protection = e.source.getActiveSheet().getRange(row,17,1,2).protect();
      protection.removeEditors(protection.getEditors());
      if (protection.canDomainEdit())
      {
        protection.setDomainEdit(false);       
      }
      if (protection.canEdit())
      {
        protection.remove();
      } 
    }
  }
}
