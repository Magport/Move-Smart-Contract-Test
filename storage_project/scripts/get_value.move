script {
    use DeveloperBob::StorageModule;

    fun get_value(account: signer) {
        StorageModule::get_value(&account);
    }
}

