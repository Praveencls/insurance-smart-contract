// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.8.2/access/Ownable.sol";

contract Insurance is Ownable {
    // Enum to represent the status of a policy
    enum PolicyStatus {
        Active,
        Inactive
    }

    // Enum to represent the status of a claim
    enum ClaimStatus {
        Submitted,
        Approved,
        Rejected
    }

    // Struct to represent an insurance policy
    struct Policy {
        uint256 policyId;
        address policyholder;
        uint256 premium;
        uint256 coverageAmount;
        uint256 expiration;
        PolicyStatus status;
    }

    // Struct to represent an insurance claim
    struct Claim {
        uint256 claimId;
        uint256 policyId;
        address claimant;
        uint256 claimAmount;
        string reason;
        ClaimStatus status;
    }

    // State variables to keep track of policies and claims
    uint256 public policyCount = 0;
    uint256 public claimCount = 0;
    mapping(uint256 => Policy) public policies;
    mapping(uint256 => Claim) public claims;
    mapping(address => bool) public authorizedInsurers;

    // Events to log important actions
    event PolicyIssued(uint256 policyId, address indexed policyholder);
    event PremiumPaid(
        uint256 policyId,
        address indexed policyholder,
        uint256 amount
    );
    event ClaimSubmitted(
        uint256 claimId,
        uint256 policyId,
        address indexed claimant
    );
    event ClaimApproved(
        uint256 claimId,
        uint256 policyId,
        address indexed claimant,
        uint256 amount
    );
    event ClaimRejected(
        uint256 claimId,
        uint256 policyId,
        address indexed claimant
    );
    event ClaimPaid(
        uint256 claimId,
        uint256 policyId,
        address indexed claimant,
        uint256 amount
    );

    // Modifier to check if the caller is an authorized insurer
    modifier onlyAuthorizedInsurer() {
        require(
            authorizedInsurers[msg.sender],
            "Caller is not an authorized insurer"
        );
        _;
    }

    // Function to authorize an insurer
    function authorizeInsurer(address insurer) external onlyOwner {
        authorizedInsurers[insurer] = true;
    }

    // Function to issue a new policy
    function issuePolicy(
        address policyholder,
        uint256 premium,
        uint256 coverageAmount,
        uint256 duration
    ) external onlyAuthorizedInsurer {
        policyCount++;
        policies[policyCount] = Policy(
            policyCount,
            policyholder,
            premium,
            coverageAmount,
            block.timestamp + duration,
            PolicyStatus.Active
        );
        emit PolicyIssued(policyCount, policyholder);
    }

    // Function to pay the premium for a policy
    function payPremium(uint256 policyId) external payable {
        Policy storage policy = policies[policyId];
        require(
            policy.policyholder == msg.sender,
            "Only the policyholder can pay the premium"
        );
        require(policy.status == PolicyStatus.Active, "Policy is not active");
        require(block.timestamp <= policy.expiration, "Policy has expired");
        require(msg.value == policy.premium, "Incorrect premium amount");

        emit PremiumPaid(policyId, msg.sender, msg.value);
    }

    // Function to submit a claim for a policy
    function submitClaim(
        uint256 policyId,
        uint256 claimAmount,
        string calldata reason
    ) external {
        Policy storage policy = policies[policyId];
        require(
            policy.policyholder == msg.sender,
            "Only the policyholder can submit a claim"
        );
        require(policy.status == PolicyStatus.Active, "Policy is not active");
        require(block.timestamp <= policy.expiration, "Policy has expired");

        claimCount++;
        claims[claimCount] = Claim(
            claimCount,
            policyId,
            msg.sender,
            claimAmount,
            reason,
            ClaimStatus.Submitted
        );

        emit ClaimSubmitted(claimCount, policyId, msg.sender);
    }

    // Function to approve a submitted claim
    function approveClaim(uint256 claimId) external onlyAuthorizedInsurer {
        Claim storage claim = claims[claimId];
        Policy storage policy = policies[claim.policyId];
        require(policy.status == PolicyStatus.Active, "Policy is not active");
        require(
            claim.status == ClaimStatus.Submitted,
            "Claim is not in a valid state"
        );

        claim.status = ClaimStatus.Approved;
        emit ClaimApproved(
            claimId,
            claim.policyId,
            claim.claimant,
            claim.claimAmount
        );
    }

    // Function to reject a submitted claim
    function rejectClaim(uint256 claimId) external onlyAuthorizedInsurer {
        Claim storage claim = claims[claimId];
        require(
            claim.status == ClaimStatus.Submitted,
            "Claim is not in a valid state"
        );

        claim.status = ClaimStatus.Rejected;
        emit ClaimRejected(claimId, claim.policyId, claim.claimant);
    }

    // Function to pay an approved claim
    function payClaim(uint256 claimId) external onlyAuthorizedInsurer {
        Claim storage claim = claims[claimId];
        require(claim.status == ClaimStatus.Approved, "Claim is not approved");

        claim.status = ClaimStatus.Rejected; // Mark as rejected to prevent re-entrancy
        payable(claim.claimant).transfer(claim.claimAmount);
        claim.status = ClaimStatus.Approved; // Mark as approved again after payment

        emit ClaimPaid(
            claimId,
            claim.policyId,
            claim.claimant,
            claim.claimAmount
        );
    }
}