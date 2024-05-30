module DeveloperBob::StorageModule {
    use std::signer;

    /// Address of the owner of this module.
    const MODULE_OWNER: address = @DeveloperBob;

    /// Error codes
    const NOT_MODULE_OWNER: u64 = 0;
    const MODULE_ALREADY_INITIALIZED: u64 = 2;
    const USER_ALREADY_EXISTS: u64 = 3;
    const USER_DOES_NOT_EXIST: u64 = 4;

    /// Struct to store a single integer value for each user.
    struct Data has key, store {
        value: u64
    }

    /// Initialize the storage for the module owner.
    public fun initialize(module_owner: &signer) {
        // Only the owner of the module can initialize this module.
        assert!(signer::address_of(module_owner) == MODULE_OWNER, NOT_MODULE_OWNER);

        // Do not initialize the module twice!
        assert!(!exists<Data>(signer::address_of(module_owner)), MODULE_ALREADY_INITIALIZED);

        // Initialize with a default value of 0.
        move_to(module_owner, Data { value: 0 });
    }

    /// Set the value for the calling user.
    public fun set_value(account: &signer, new_value: u64) acquires Data {
        let data = borrow_global_mut<Data>(signer::address_of(account));
        data.value = new_value;
    }

    /// Get the value for the calling user.
    public fun get_value(account: &signer): u64 acquires Data {
        let data = borrow_global<Data>(signer::address_of(account));
        data.value
    }
}

