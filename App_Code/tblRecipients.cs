using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace MAILER
{
    /// <summary>
    /// Summary description for tblRecipients
    /// </summary>
    public class tblRecipients
    {


        public int recipientId { get; set; }
        public int categoryId { get; set; }
        public string name { get; set; }
        public string email { get; set; }
    }
}

