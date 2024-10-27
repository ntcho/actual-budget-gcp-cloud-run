data "google_billing_account" "account" {
  billing_account = var.billing_account_id
}

resource "google_billing_budget" "budget" {
  billing_account = data.google_billing_account.account.id
  display_name    = "MonthlyBudgetAlert"
  amount {
    specified_amount {
      currency_code = "SGD"
      units         = "1"
    }
  }
  threshold_rules {
    threshold_percent = 0.5
  }

  threshold_rules {
    threshold_percent = 0.9
  }

  threshold_rules {
    threshold_percent = 1
  }

  threshold_rules {
    threshold_percent = 1.5
  }
}