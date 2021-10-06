// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.6;

import "./ITicket.sol";
import "./IDrawBuffer.sol";
import "../PrizeDistributionHistory.sol";
import "../PrizeDistributor.sol";

/**
 * @title  PoolTogether V4 IDrawCalculator
 * @author PoolTogether Inc Team
 * @notice The DrawCalculator interface.
 */
interface IDrawCalculator {
    struct PickPrize {
        bool won;
        uint8 tierIndex;
    }

    ///@notice Emitted when the contract is initialized
    event Deployed(ITicket indexed ticket,
     IDrawBuffer indexed drawBuffer,
    IPrizeDistributionHistory indexed prizeDistributionHistory);

    ///@notice Emitted when the prizeDistributor is set/updated
    event PrizeDistributorSet(PrizeDistributor indexed prizeDistributor);

    /**
     * @notice Calculates the prize amount for a user for Multiple Draws. Typically called by a PrizeDistributor.
     * @param user User for which to calculate prize amount.
     * @param drawIds drawId array for which to calculate prize amounts for.
     * @param data The ABI encoded pick indices for all Draws. Expected to be winning picks. Pick indices must be less than the totalUserPicks.
     * @return List of awardable prize amounts ordered by drawId.
     */
    function calculate(
        address user,
        uint32[] calldata drawIds,
        bytes calldata data
    ) external view returns (uint256[] memory);

    /**
     * @notice Read global DrawBuffer variable.
     * @return IDrawBuffer
     */
    function getDrawBuffer() external view returns (IDrawBuffer);

    /**
     * @notice Read global DrawBuffer variable.
     * @return IDrawBuffer
     */
    function getPrizeDistributionHistory() external view returns (IPrizeDistributionHistory);

    /**
     * @notice Returns a users balances expressed as a fraction of the total supply over time.
     * @param user The users address
     * @param drawIds The drawsId to consider
     * @return Array of balances
     */
    function getNormalizedBalancesForDrawIds(address user, uint32[] calldata drawIds)
        external
        view
        returns (uint256[] memory);

    /**
     * @notice Returns a users balances expressed as a fraction of the total supply over time.
     * @param user The user for which to calculate the tiers indices
     * @param pickIndices The users pick indices for a draw
     * @param drawId The draw for which to calculate the tiers indices
     * @return List of PrizePicks for Draw.drawId
     */
    function checkPrizeTierIndexForDrawId(
        address user,
        uint64[] calldata pickIndices,
        uint32 drawId
    ) external view returns (PickPrize[] memory);
}
