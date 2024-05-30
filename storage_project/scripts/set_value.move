script {
    use DeveloperBob::StorageModule;

    fun set_value(account: signer, new_value: u64) {
        StorageModule::set_value(&account, new_value);
    }
}

