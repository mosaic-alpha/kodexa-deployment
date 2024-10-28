/**
 *Submitted for verification at BscScan.com on 2022-03-02
*/

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.0 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// OpenZeppelin Contracts v4.4.0 (utils/Address.sol)



/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
// Kodexa Contracts v1.0 developed by Dlabs/Peter Molnar


/**
 * @dev Role constants
 */

library Roles {
    uint8 constant OWNER = 0;
    uint8 constant MANAGER = 1;
    uint8 constant WALLETFACTORY_OPERATOR = 2;
    uint8 constant WALLET_OPERATOR = 3;
    uint8 constant KODEXA_MINTER = 4;
    uint8 constant KODEXA_WHITELIST_MANAGER = 5;


    function roleToMask(uint8 _role) public pure returns (uint256){
        return (1 << _role);
    }
}
// OpenZeppelin Contracts v4.4.0 (utils/introspection/IERC165.sol)



/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}




// OpenZeppelin Contracts v4.4.0 (token/ERC20/extensions/ERC20Burnable.sol)




// OpenZeppelin Contracts v4.4.0 (token/ERC20/ERC20.sol)




// OpenZeppelin Contracts v4.4.0 (token/ERC20/IERC20.sol)



/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// OpenZeppelin Contracts v4.4.0 (token/ERC20/extensions/IERC20Metadata.sol)





/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}



/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(sender, _msgSender(), currentAllowance - amount);
        }

        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        _afterTokenTransfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}



/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
abstract contract ERC20Burnable is Context, ERC20 {
    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance.
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `amount`.
     */
    function burnFrom(address account, uint256 amount) public virtual {
        uint256 currentAllowance = allowance(account, _msgSender());
        require(currentAllowance >= amount, "ERC20: burn amount exceeds allowance");
        unchecked {
            _approve(account, _msgSender(), currentAllowance - amount);
        }
        _burn(account, amount);
    }
}



// OpenZeppelin Contracts v4.4.0 (utils/introspection/ERC165Checker.sol)





/**
 * @dev Library used to query support of an interface declared via {IERC165}.
 *
 * Note that these functions return the actual result of the query: they do not
 * `revert` if an interface is not supported. It is up to the caller to decide
 * what to do in these cases.
 */
library ERC165Checker {
    // As per the EIP-165 spec, no interface should ever match 0xffffffff
    bytes4 private constant _INTERFACE_ID_INVALID = 0xffffffff;

    /**
     * @dev Returns true if `account` supports the {IERC165} interface,
     */
    function supportsERC165(address account) internal view returns (bool) {
        // Any contract that implements ERC165 must explicitly indicate support of
        // InterfaceId_ERC165 and explicitly indicate non-support of InterfaceId_Invalid
        return
            _supportsERC165Interface(account, type(IERC165).interfaceId) &&
            !_supportsERC165Interface(account, _INTERFACE_ID_INVALID);
    }

    /**
     * @dev Returns true if `account` supports the interface defined by
     * `interfaceId`. Support for {IERC165} itself is queried automatically.
     *
     * See {IERC165-supportsInterface}.
     */
    function supportsInterface(address account, bytes4 interfaceId) internal view returns (bool) {
        // query support of both ERC165 as per the spec and support of _interfaceId
        return supportsERC165(account) && _supportsERC165Interface(account, interfaceId);
    }

    /**
     * @dev Returns a boolean array where each value corresponds to the
     * interfaces passed in and whether they're supported or not. This allows
     * you to batch check interfaces for a contract where your expectation
     * is that some interfaces may not be supported.
     *
     * See {IERC165-supportsInterface}.
     *
     * _Available since v3.4._
     */
    function getSupportedInterfaces(address account, bytes4[] memory interfaceIds)
        internal
        view
        returns (bool[] memory)
    {
        // an array of booleans corresponding to interfaceIds and whether they're supported or not
        bool[] memory interfaceIdsSupported = new bool[](interfaceIds.length);

        // query support of ERC165 itself
        if (supportsERC165(account)) {
            // query support of each interface in interfaceIds
            for (uint256 i = 0; i < interfaceIds.length; i++) {
                interfaceIdsSupported[i] = _supportsERC165Interface(account, interfaceIds[i]);
            }
        }

        return interfaceIdsSupported;
    }

    /**
     * @dev Returns true if `account` supports all the interfaces defined in
     * `interfaceIds`. Support for {IERC165} itself is queried automatically.
     *
     * Batch-querying can lead to gas savings by skipping repeated checks for
     * {IERC165} support.
     *
     * See {IERC165-supportsInterface}.
     */
    function supportsAllInterfaces(address account, bytes4[] memory interfaceIds) internal view returns (bool) {
        // query support of ERC165 itself
        if (!supportsERC165(account)) {
            return false;
        }

        // query support of each interface in _interfaceIds
        for (uint256 i = 0; i < interfaceIds.length; i++) {
            if (!_supportsERC165Interface(account, interfaceIds[i])) {
                return false;
            }
        }

        // all interfaces supported
        return true;
    }

    /**
     * @notice Query if a contract implements an interface, does not check ERC165 support
     * @param account The address of the contract to query for support of an interface
     * @param interfaceId The interface identifier, as specified in ERC-165
     * @return true if the contract at account indicates support of the interface with
     * identifier interfaceId, false otherwise
     * @dev Assumes that account contains a contract that supports ERC165, otherwise
     * the behavior of this method is undefined. This precondition can be checked
     * with {supportsERC165}.
     * Interface identification is specified in ERC-165.
     */
    function _supportsERC165Interface(address account, bytes4 interfaceId) private view returns (bool) {
        bytes memory encodedParams = abi.encodeWithSelector(IERC165.supportsInterface.selector, interfaceId);
        (bool success, bytes memory result) = account.staticcall{gas: 30000}(encodedParams);
        if (result.length < 32) return false;
        return success && abi.decode(result, (bool));
    }
}

// Kodexa Contracts v1.0 developed by Dlabs/Peter Molnar


/**
 * @dev Pluggable, chainable role management module
 */


interface IExternalOwnerManagerRegistry {
    function isOwner(address) external view returns (bool);
    function isManager(address) external view returns (bool);
    function hasRole(address, uint8) external view returns (bool);
    function hasRoleByMask(address, uint256) external view returns (bool);
    function getAllRoles(address) external view returns (uint256);
}

contract OwnableManageableChainableRoles is IExternalOwnerManagerRegistry {
    address[] public managers;
    address[] public owners;
    mapping(address => uint256) rolesMap;
    address public extRegistry;

    function hasRole(address _address, uint8 _role) external view returns (bool) {
        return _hasRole(_address, _role);
    }
    function _hasRole(address _address, uint8 _role) internal view returns (bool) {
        return (rolesMap[_address] & (1 << _role)) > 0 || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).hasRole(_address, _role);
    }
    function hasRoleByMask(address _address, uint256 _roleMask) external view returns (bool) {
        return _hasRoleByMask(_address, _roleMask);
    }
    function _hasRoleByMask(address _address, uint256 _roleMask) internal view returns (bool) {
        return rolesMap[_address] & _roleMask > 0 || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).hasRoleByMask(_address, _roleMask);
    }
    function hasLocalRole(address _address, uint8 _role) external view returns (bool) {
        return _hasLocalRole(_address, _role);
    }
    function _hasLocalRole(address _address, uint8 _role) internal view returns (bool) {
        return (rolesMap[_address] & (1 << _role)) > 0;
    }
    function getAllRoles(address _address) external view returns (uint256){
        return _getAllRoles(_address);
    }
    function hasLocalRoleByMask(address _address, uint256 _roleMask) external view returns (bool) {
        return _hasLocalRoleByMask( _address,  _roleMask);
    }
    function _hasLocalRoleByMask(address _address, uint256 _roleMask) internal view returns (bool) {
        return rolesMap[_address] & _roleMask > 0;
    }
    function _getAllRoles(address _address) internal view returns (uint256){
        if (extRegistry == address(0)) {
            return rolesMap[_address];
        } else {
            return rolesMap[_address] | IExternalOwnerManagerRegistry(extRegistry).getAllRoles(_address);
        }
    }
    function getAllLocalRoles(address _address) external view returns (uint256){
        return _getAllLocalRoles(_address);
    }
    function _getAllLocalRoles(address _address) internal view returns (uint256){
        return rolesMap[_address];
    }


    function isOwner(address _address) external view returns (bool) {
        return _isOwner(_address);//ownerMap[_address] || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).isOwner(_address);
    }
    function _isOwner(address _address) internal view returns (bool) {
        //return ownerMap[_address] || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).isOwner(_address);
        return _hasLocalRole(_address, Roles.OWNER) || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).isOwner(_address);
    }
    function isManager(address _address) external view returns (bool) {
        return _isManager(_address);//managerMap[_address] || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).isManager(_address);
    }
    function _isManager(address _address) internal view returns (bool) {
        //return managerMap[_address] || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).isManager(_address);
        return _hasLocalRole(_address, Roles.MANAGER) || extRegistry != address(0) && IExternalOwnerManagerRegistry(extRegistry).isManager(_address);
    }
    function isLocalOwner(address _address) external view returns (bool) {
        return _hasLocalRole(_address, Roles.OWNER) ;
    }
    function _isLocalOwner(address _address) internal view returns (bool) {
        return _hasLocalRole(_address, Roles.OWNER) ;
    }
    function isLocalManager(address _address) external view returns (bool) {
        return _hasLocalRole(_address, Roles.MANAGER) ;
    }
    function _isLocalManager(address _address) internal view returns (bool) {
        return _hasLocalRole(_address, Roles.MANAGER) ;
    }

    modifier onlyOwner() {
        require(_isOwner(msg.sender));
        _;
    }

    modifier onlyManager() {
        require(_isManager(msg.sender));
        _;
    }
    
    modifier onlyWithRole(uint8 _role) {
        require(_hasRole(msg.sender, _role));
        _;
    }

    modifier onlyWithRoleMask(uint256 _roleMask) {
        require(_hasRoleByMask(msg.sender, _roleMask));
        _;
    }

    modifier onlyLocalOwner() {
        require(_isLocalOwner(msg.sender));
        _;
    }

    modifier onlyLocalManager() {
        require(_isLocalManager(msg.sender));
        _;
    }

    modifier onlyWithLocalRole(uint8 _role) {
        require(_hasLocalRole(msg.sender, _role));
        _;
    }

    modifier onlyWithLocalRoleMask(uint256 _roleMask) {
        require(_hasLocalRoleByMask(msg.sender, _roleMask));
        _;
    }


    constructor(address[] memory _ownrs, address _extreg) {
        extRegistry = _extreg;
        for (uint i=0; i < _ownrs.length; i++)
            _addOwner(_ownrs[i]);
    }

    event ExternalRegistryAddressChanged(address addr);
    function setExternalRegistryAddress(address _extreg) external onlyOwner() {
        // avoid accidentaly rendering everything unusable by ensuring that 0 address can't be set unless there are local owners
        require(address(0) == _extreg && owners.length > 0 ||  Address.isContract(_extreg));
        // should revert if not implemented
        if (Address.isContract(_extreg)) {
            IExternalOwnerManagerRegistry(_extreg).isOwner(address(0));
            IExternalOwnerManagerRegistry(_extreg).isManager(address(0));
        }
        extRegistry = _extreg;
        emit ExternalRegistryAddressChanged(_extreg);
    }

    event RoleAdded(address addr, uint8 role);
    function setRole(address _address, uint8 _role) external onlyManager() {
        require(_role != Roles.OWNER && _role != Roles.MANAGER);
        _setRole(_address, _role);
    }

    function _setRole(address _address, uint8 _role) internal {
        require(rolesMap[_address] & (1 << _role) == 0);
        rolesMap[_address] = rolesMap[_address] | (1 << _role);
        if (_role != Roles.OWNER && _role != Roles.MANAGER) emit RoleAdded(_address, _role);
    }

    event RoleRemoved(address addr, uint8 role);
    function unsetRole(address _address, uint8 _role) external onlyManager() {
        require(_role != Roles.OWNER && _role != Roles.MANAGER);
        _unsetRole(_address, _role);
    }

    function _unsetRole(address _address, uint8 _role) internal {
        require((rolesMap[_address] & (1 << _role)) > 0);
        uint256 intmax;
        unchecked { intmax = uint256(0) - 1;}
        uint256 tmp = rolesMap[_address] & (intmax ^ (uint256(1) << _role));

        if (tmp == 0) {
            delete(rolesMap[_address]);
        } else {
            rolesMap[_address] = tmp;
        }
        if (_role != Roles.OWNER && _role != Roles.MANAGER) emit RoleRemoved(_address, _role);
    }

    event AllRolesSet(address addr, uint256 roles);
    function setAllRoles(address _address, uint256 _roles) external onlyOwner() {
        _setAllRoles(_address, _roles);
    }

    function _setAllRoles(address _address, uint256 _roles) internal {
        rolesMap[_address] = _roles;
        emit AllRolesSet(_address, _roles);
    }

    event OwnerAdded(address owner);
    function addOwner(address _ownr) public onlyOwner() {
        _addOwner(_ownr);
    }

    function _addOwner(address _ownr) internal {
        if (!_hasLocalRole(_ownr, Roles.OWNER)) {
            _setRole(_ownr, Roles.OWNER);
            owners.push(_ownr);
            emit OwnerAdded(_ownr);
        } else revert();
    }

    event OwnerRevoked(address owner);
    function revokeOwner(address _ownr) public onlyOwner {
        // cant revoke if not admin and cant revoke last owner
        if (_hasLocalRole(_ownr, Roles.OWNER) && (owners.length > 1 || extRegistry != address(0))) {
            _unsetRole(_ownr, Roles.OWNER);
            for (uint i=0; i < owners.length; i++){
                if (owners[i] == _ownr) {
                    owners[i] = owners[owners.length-1];
                    owners.pop();
                    break;
                }
            }
            emit OwnerRevoked(_ownr);
        } else revert();
    }

    event ManagerAdded(address manager);
    function addManager(address _mgr) public onlyOwner() {
        _addManager(_mgr);
    }
    function _addManager(address _mgr) internal {
        if (!_hasLocalRole(_mgr, Roles.MANAGER)) {
            _setRole(_mgr, Roles.MANAGER);
            managers.push(_mgr);
            emit ManagerAdded(_mgr);
        } else revert();
    }

    event ManagerRevoked(address manager);
    function revokeManager(address _mgr) public onlyOwner() {
        if (_hasLocalRole(_mgr, Roles.MANAGER)) {
            _unsetRole(_mgr, Roles.MANAGER);
            for (uint i=0; i < managers.length; i++){
                if (managers[i] == _mgr) {
                    managers[i] = managers[managers.length-1];
                    managers.pop();
                    break;
                }
            }
            emit ManagerRevoked(_mgr);
        } else revert();
    }
}
// Kodexa Contracts v1.0 developed by Dlabs/Peter Molnar


/**
 * @dev KDX interfaces and token module
 */

interface IKodexaReceiver is IERC165{
  function onKodexaReceived(
    address from,
    uint256 amount
  ) external returns (bool);
}

interface IKodexaSender is IERC165{
  function onKodexaToSend(
    address to,
    uint256 amount
  ) external returns (bool);
}

contract KodexaToken is ERC20Burnable, OwnableManageableChainableRoles {
  using Address for address;
  using ERC165Checker for address;

  mapping(address => bool) public contractWhitelist;
  mapping(address => bool) public addressBlacklist;
  mapping(address => bool) public beforeSendSubscription;
  mapping(address => bool) public afterReceiveSubscription;
  bool private _isWhitelistEnabled;
  bool private _isBlacklistEnabled;
  bool private _isCallbackEnabled;
  bool private _mintable;
  bool private _locked;
  address[] public secondaryWhitelistAddresses;
  string[] public secondaryWhitelistCallStrings;

  constructor(
    string memory name,
    string memory symbol,
    uint256 initialSupply,
    address initialSupplyOwner,
    address[] memory _owners,
    address _extreg
  ) 
  OwnableManageableChainableRoles(_owners, _extreg)
  ERC20(name, symbol) 
  {
    _mintable = true;
    _mint(initialSupplyOwner, initialSupply);
    _isWhitelistEnabled = true;
    _isBlacklistEnabled = true;
    _isCallbackEnabled = true;
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual override {
    require((!isWhitelistEnabled() || !to.isContract() || isWhitelisted(to)) && (!isBlacklistEnabled() || !isBlacklisted(to)), 
      "Kodexa: transfer to non-whitelisted contract");
    if(_isCallbackEnabled && beforeSendSubscription[from])
    {
      require(IKodexaSender(from).onKodexaToSend(to, amount));
    }
  }

  function _afterTokenTransfer(
      address from,
      address to,
      uint256 amount
  ) internal virtual override{
    //bytes4(keccak256("onKodexaReceived(from,amount)")) => 0xea8fe7da
    if(_isCallbackEnabled && afterReceiveSubscription[to])
    {
      require(IKodexaReceiver(to).onKodexaReceived(from, amount));
    }
  }

  modifier notLocked() {
    require(!_locked);
    _;
  }

  function mint(address _to, uint256 _amount) public onlyWithRole(Roles.KODEXA_MINTER) notLocked() {
    require(_mintable);
      _mint(_to, _amount);
  }

  function disableMinting() public onlyOwner() {
      _mintable = false;
  }

  function enableMinting() public onlyOwner() notLocked() {
      _mintable = true;
  }

  function addToWhitelist(address _address) public onlyWithRole(Roles.KODEXA_WHITELIST_MANAGER) notLocked() {
      contractWhitelist[_address] = true;
  }

  function removeFromWhitelist(address _address) public onlyWithRole(Roles.KODEXA_WHITELIST_MANAGER) notLocked() {
      delete contractWhitelist[_address];
  }

  function isWhitelisted(address _address) public view returns(bool) {
      if (contractWhitelist[_address]) return true;
      for (uint256 i = 0; i < secondaryWhitelistAddresses.length; i++) {
        if (secondaryWhitelistAddresses[i] != address(0)) { 
          (bool success, bytes memory data) = secondaryWhitelistAddresses[i].staticcall(abi.encodeWithSignature(secondaryWhitelistCallStrings[i], _address));
          if (success == true && data[31] > 0) return true;
        }
      }
      return false;
  }

  function enableWhitelist() public onlyOwner() notLocked() {
      _isWhitelistEnabled = true;
  }

  function disableWhitelist() public onlyOwner() notLocked() {
      _isWhitelistEnabled = false;
  }

  function isWhitelistEnabled() public view returns(bool) {
      return _isWhitelistEnabled;
  }

  function addSecondaryWhitelist(address _address, string calldata _callstring) external onlyOwner() notLocked(){
      secondaryWhitelistAddresses.push(_address);
      secondaryWhitelistCallStrings.push(_callstring);
  }

  function removeSecondaryWhitelist(uint256 _idx) external onlyOwner() notLocked() {
      require(_idx < secondaryWhitelistAddresses.length);
      secondaryWhitelistAddresses[_idx] = secondaryWhitelistAddresses[secondaryWhitelistAddresses.length - 1];
      secondaryWhitelistCallStrings[_idx] = secondaryWhitelistCallStrings[secondaryWhitelistCallStrings.length - 1];
      secondaryWhitelistAddresses.pop();
      secondaryWhitelistCallStrings.pop();
  }

  function addToBlacklist(address _address) public onlyWithRole(Roles.KODEXA_WHITELIST_MANAGER) notLocked() {
      addressBlacklist[_address] = true;
  }

  function removeFromBlacklist(address _address) public onlyWithRole(Roles.KODEXA_WHITELIST_MANAGER) notLocked() {
      delete addressBlacklist[_address];
  }

  function isBlacklisted(address _address) public view returns(bool) {
      return addressBlacklist[_address];
  }

  function enableBlacklist() public onlyOwner() notLocked() {
      _isBlacklistEnabled = true;
  }

  function disableBlacklist() public onlyOwner() notLocked() {
      _isBlacklistEnabled = false;
  }

  function isBlacklistEnabled() public view returns(bool) {
      return _isBlacklistEnabled;
  }

  function enableCallback() public onlyOwner() notLocked() {
      _isCallbackEnabled = true;
  }

  function disableCallback() public onlyOwner() notLocked() {
      _isCallbackEnabled = false;
  }

  function isCallbackEnabled() public view returns(bool) {
      return _isCallbackEnabled;
  }

  function isMintable() public view returns(bool) {
      return _mintable;
  }

  function lockContract() public onlyOwner() {
      _locked = true;
  }

  function isLocked() public view returns(bool) {
      return _locked;
  }

  function subscribeToBeforeTokenSend(bool subscribe) public {
      //bytes4(keccak256("onKodexaToSend(to,amount)")) => 0x9dfb25d4
      require (Address.isContract(_msgSender()) && IKodexaSender(_msgSender()).supportsInterface(0x9dfb25d4));
      beforeSendSubscription[msg.sender] = subscribe;
  }

  function subscribeToAfterTokenReceived(bool subscribe) public {
      //bytes4(keccak256("onKodexaReceived(from,amount)")) => 0xea8fe7da
      require (Address.isContract(_msgSender()) && IKodexaReceiver(_msgSender()).supportsInterface(0xea8fe7da));
      afterReceiveSubscription[msg.sender] = subscribe;
  }
}
