/*
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized
 * by MyEclipse Hibernate tool integration.
 *
 * Created Thu Sep 01 09:31:37 CST 2005 by MyEclipse Hibernate Tool.
 */
package com.kingstargroup.ecard.hibernate.account;

import java.io.Serializable;

/**
 * A class that represents a row in the T_AIF_ACCOUNT table. 
 * You can customize the behavior of this class by editing the class, {@link TAifAccount()}.
 * WARNING: DO NOT EDIT THIS FILE. This is a generated file that is synchronized * by MyEclipse Hibernate tool integration.
 */
public abstract class AbstractTAifAccount 
    extends com.kingstargroup.ecard.common.BasicPersistence
    implements Serializable
{
    /** The cached hash code value for this instance.  Settting to 0 triggers re-calculation. */
    private int hashValue = 0;

    /** The composite primary key value. */
    private java.lang.String accountId;

    /** The value of the simple actType property. */
    private java.lang.Integer actType;

    /** The value of the simple customerId property. */
    private java.lang.Integer customerId;

    /** The value of the simple cutName property. */
    private java.lang.String cutName;

    /** The value of the simple cutType property. */
    private java.lang.Integer cutType;

    /** The value of the simple stuempNo property. */
    private java.lang.String stuempNo;

    /** The value of the simple cardId property. */
    private java.lang.Integer cardId;

    /** The value of the simple purseId property. */
    private java.lang.Integer purseId;

    /** The value of the simple cardType property. */
    private java.lang.Integer cardType;

    /** The value of the simple subno property. */
    private java.lang.String subno;

    /** The value of the simple password property. */
    private java.lang.String password;

    /** The value of the simple currentState property. */
    private java.lang.Integer currentState;

    /** The value of the simple isautotra property. */
    private java.lang.String isautotra;

    /** The value of the simple lastBala property. */
    private java.lang.Double lastBala;

    /** The value of the simple lastFreebala property. */
    private java.lang.Double lastFreebala;

    /** The value of the simple lastFrozebala property. */
    private java.lang.Double lastFrozebala;

    /** The value of the simple curBala property. */
    private java.lang.Double curBala;

    /** The value of the simple curFreebala property. */
    private java.lang.Double curFreebala;

    /** The value of the simple curFrozebala property. */
    private java.lang.Double curFrozebala;

    /** The value of the simple outBala property. */
    private java.lang.Double outBala;

    /** The value of the simple inBala property. */
    private java.lang.Double inBala;

    /** The value of the simple outCount property. */
    private java.lang.Integer outCount;

    /** The value of the simple inCount property. */
    private java.lang.Integer inCount;

    /** The value of the simple cardBalance property. */
    private java.lang.Double cardBalance;

    /** The value of the simple nobalaNum property. */
    private java.lang.Integer nobalaNum;

    /** The value of the simple consumeCount property. */
    private java.lang.Integer consumeCount;

    /** The value of the simple openDate property. */
    private java.lang.String openDate;

    /** The value of the simple openTime property. */
    private java.lang.String openTime;

    /** The value of the simple closeDate property. */
    private java.lang.String closeDate;

    /** The value of the simple closeTime property. */
    private java.lang.String closeTime;

    /** The value of the simple reserve1 property. */
    private java.lang.String reserve1;

    /** The value of the simple reserve2 property. */
    private java.lang.String reserve2;

    /** The value of the simple reserve3 property. */
    private java.lang.String reserve3;

    /** The value of the simple comments property. */
    private java.lang.String comments;

    /** The value of the simple depositBala property. */
    private java.lang.Double depositBala;

    /**
     * Simple constructor of AbstractTAifAccount instances.
     */
    public AbstractTAifAccount()
    {
    }

    /**
     * Constructor of AbstractTAifAccount instances given a simple primary key.
     * @param accountId
     */
    public AbstractTAifAccount(java.lang.String accountId)
    {
        this.setAccountId(accountId);
    }

    /**
     * Return the simple primary key value that identifies this object.
     * @return java.lang.String
     */
    public java.lang.String getAccountId()
    {
        return accountId;
    }

    /**
     * Set the simple primary key value that identifies this object.
     * @param accountId
     */
    public void setAccountId(java.lang.String accountId)
    {
        this.hashValue = 0;
        this.accountId = accountId;
    }

    /**
     * Return the value of the ACT_TYPE column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getActType()
    {
        return this.actType;
    }

    /**
     * Set the value of the ACT_TYPE column.
     * @param actType
     */
    public void setActType(java.lang.Integer actType)
    {
        this.actType = actType;
    }

    /**
     * Return the value of the CUSTOMER_ID column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getCustomerId()
    {
        return this.customerId;
    }

    /**
     * Set the value of the CUSTOMER_ID column.
     * @param customerId
     */
    public void setCustomerId(java.lang.Integer customerId)
    {
        this.customerId = customerId;
    }

    /**
     * Return the value of the CUT_NAME column.
     * @return java.lang.String
     */
    public java.lang.String getCutName()
    {
        return this.cutName;
    }

    /**
     * Set the value of the CUT_NAME column.
     * @param cutName
     */
    public void setCutName(java.lang.String cutName)
    {
        this.cutName = cutName;
    }

    /**
     * Return the value of the CUT_TYPE column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getCutType()
    {
        return this.cutType;
    }

    /**
     * Set the value of the CUT_TYPE column.
     * @param cutType
     */
    public void setCutType(java.lang.Integer cutType)
    {
        this.cutType = cutType;
    }

    /**
     * Return the value of the STUEMP_NO column.
     * @return java.lang.String
     */
    public java.lang.String getStuempNo()
    {
        return this.stuempNo;
    }

    /**
     * Set the value of the STUEMP_NO column.
     * @param stuempNo
     */
    public void setStuempNo(java.lang.String stuempNo)
    {
        this.stuempNo = stuempNo;
    }

    /**
     * Return the value of the CARD_ID column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getCardId()
    {
        return this.cardId;
    }

    /**
     * Set the value of the CARD_ID column.
     * @param cardId
     */
    public void setCardId(java.lang.Integer cardId)
    {
        this.cardId = cardId;
    }

    /**
     * Return the value of the PURSE_ID column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getPurseId()
    {
        return this.purseId;
    }

    /**
     * Set the value of the PURSE_ID column.
     * @param purseId
     */
    public void setPurseId(java.lang.Integer purseId)
    {
        this.purseId = purseId;
    }

    /**
     * Return the value of the CARD_TYPE column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getCardType()
    {
        return this.cardType;
    }

    /**
     * Set the value of the CARD_TYPE column.
     * @param cardType
     */
    public void setCardType(java.lang.Integer cardType)
    {
        this.cardType = cardType;
    }

    /**
     * Return the value of the SUBNO column.
     * @return java.lang.String
     */
    public java.lang.String getSubno()
    {
        return this.subno;
    }

    /**
     * Set the value of the SUBNO column.
     * @param subno
     */
    public void setSubno(java.lang.String subno)
    {
        this.subno = subno;
    }

    /**
     * Return the value of the PASSWORD column.
     * @return java.lang.String
     */
    public java.lang.String getPassword()
    {
        return this.password;
    }

    /**
     * Set the value of the PASSWORD column.
     * @param password
     */
    public void setPassword(java.lang.String password)
    {
        this.password = password;
    }

    /**
     * Return the value of the CURRENT_STATE column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getCurrentState()
    {
        return this.currentState;
    }

    /**
     * Set the value of the CURRENT_STATE column.
     * @param currentState
     */
    public void setCurrentState(java.lang.Integer currentState)
    {
        this.currentState = currentState;
    }

    /**
     * Return the value of the ISAUTOTRA column.
     * @return java.lang.String
     */
    public java.lang.String getIsautotra()
    {
        return this.isautotra;
    }

    /**
     * Set the value of the ISAUTOTRA column.
     * @param isautotra
     */
    public void setIsautotra(java.lang.String isautotra)
    {
        this.isautotra = isautotra;
    }

    /**
     * Return the value of the LAST_BALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getLastBala()
    {
        return this.lastBala;
    }

    /**
     * Set the value of the LAST_BALA column.
     * @param lastBala
     */
    public void setLastBala(java.lang.Double lastBala)
    {
        this.lastBala = lastBala;
    }

    /**
     * Return the value of the LAST_FREEBALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getLastFreebala()
    {
        return this.lastFreebala;
    }

    /**
     * Set the value of the LAST_FREEBALA column.
     * @param lastFreebala
     */
    public void setLastFreebala(java.lang.Double lastFreebala)
    {
        this.lastFreebala = lastFreebala;
    }

    /**
     * Return the value of the LAST_FROZEBALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getLastFrozebala()
    {
        return this.lastFrozebala;
    }

    /**
     * Set the value of the LAST_FROZEBALA column.
     * @param lastFrozebala
     */
    public void setLastFrozebala(java.lang.Double lastFrozebala)
    {
        this.lastFrozebala = lastFrozebala;
    }

    /**
     * Return the value of the CUR_BALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getCurBala()
    {
        return this.curBala;
    }

    /**
     * Set the value of the CUR_BALA column.
     * @param curBala
     */
    public void setCurBala(java.lang.Double curBala)
    {
        this.curBala = curBala;
    }

    /**
     * Return the value of the CUR_FREEBALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getCurFreebala()
    {
        return this.curFreebala;
    }

    /**
     * Set the value of the CUR_FREEBALA column.
     * @param curFreebala
     */
    public void setCurFreebala(java.lang.Double curFreebala)
    {
        this.curFreebala = curFreebala;
    }

    /**
     * Return the value of the CUR_FROZEBALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getCurFrozebala()
    {
        return this.curFrozebala;
    }

    /**
     * Set the value of the CUR_FROZEBALA column.
     * @param curFrozebala
     */
    public void setCurFrozebala(java.lang.Double curFrozebala)
    {
        this.curFrozebala = curFrozebala;
    }

    /**
     * Return the value of the OUT_BALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getOutBala()
    {
        return this.outBala;
    }

    /**
     * Set the value of the OUT_BALA column.
     * @param outBala
     */
    public void setOutBala(java.lang.Double outBala)
    {
        this.outBala = outBala;
    }

    /**
     * Return the value of the IN_BALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getInBala()
    {
        return this.inBala;
    }

    /**
     * Set the value of the IN_BALA column.
     * @param inBala
     */
    public void setInBala(java.lang.Double inBala)
    {
        this.inBala = inBala;
    }

    /**
     * Return the value of the OUT_COUNT column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getOutCount()
    {
        return this.outCount;
    }

    /**
     * Set the value of the OUT_COUNT column.
     * @param outCount
     */
    public void setOutCount(java.lang.Integer outCount)
    {
        this.outCount = outCount;
    }

    /**
     * Return the value of the IN_COUNT column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getInCount()
    {
        return this.inCount;
    }

    /**
     * Set the value of the IN_COUNT column.
     * @param inCount
     */
    public void setInCount(java.lang.Integer inCount)
    {
        this.inCount = inCount;
    }

    /**
     * Return the value of the CARD_BALANCE column.
     * @return java.lang.Double
     */
    public java.lang.Double getCardBalance()
    {
        return this.cardBalance;
    }

    /**
     * Set the value of the CARD_BALANCE column.
     * @param cardBalance
     */
    public void setCardBalance(java.lang.Double cardBalance)
    {
        this.cardBalance = cardBalance;
    }

    /**
     * Return the value of the NOBALA_NUM column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getNobalaNum()
    {
        return this.nobalaNum;
    }

    /**
     * Set the value of the NOBALA_NUM column.
     * @param nobalaNum
     */
    public void setNobalaNum(java.lang.Integer nobalaNum)
    {
        this.nobalaNum = nobalaNum;
    }

    /**
     * Return the value of the CONSUME_COUNT column.
     * @return java.lang.Integer
     */
    public java.lang.Integer getConsumeCount()
    {
        return this.consumeCount;
    }

    /**
     * Set the value of the CONSUME_COUNT column.
     * @param consumeCount
     */
    public void setConsumeCount(java.lang.Integer consumeCount)
    {
        this.consumeCount = consumeCount;
    }

    /**
     * Return the value of the OPEN_DATE column.
     * @return java.lang.String
     */
    public java.lang.String getOpenDate()
    {
        return this.openDate;
    }

    /**
     * Set the value of the OPEN_DATE column.
     * @param openDate
     */
    public void setOpenDate(java.lang.String openDate)
    {
        this.openDate = openDate;
    }

    /**
     * Return the value of the OPEN_TIME column.
     * @return java.lang.String
     */
    public java.lang.String getOpenTime()
    {
        return this.openTime;
    }

    /**
     * Set the value of the OPEN_TIME column.
     * @param openTime
     */
    public void setOpenTime(java.lang.String openTime)
    {
        this.openTime = openTime;
    }

    /**
     * Return the value of the CLOSE_DATE column.
     * @return java.lang.String
     */
    public java.lang.String getCloseDate()
    {
        return this.closeDate;
    }

    /**
     * Set the value of the CLOSE_DATE column.
     * @param closeDate
     */
    public void setCloseDate(java.lang.String closeDate)
    {
        this.closeDate = closeDate;
    }

    /**
     * Return the value of the CLOSE_TIME column.
     * @return java.lang.String
     */
    public java.lang.String getCloseTime()
    {
        return this.closeTime;
    }

    /**
     * Set the value of the CLOSE_TIME column.
     * @param closeTime
     */
    public void setCloseTime(java.lang.String closeTime)
    {
        this.closeTime = closeTime;
    }

    /**
     * Return the value of the RESERVE_1 column.
     * @return java.lang.String
     */
    public java.lang.String getReserve1()
    {
        return this.reserve1;
    }

    /**
     * Set the value of the RESERVE_1 column.
     * @param reserve1
     */
    public void setReserve1(java.lang.String reserve1)
    {
        this.reserve1 = reserve1;
    }

    /**
     * Return the value of the RESERVE_2 column.
     * @return java.lang.String
     */
    public java.lang.String getReserve2()
    {
        return this.reserve2;
    }

    /**
     * Set the value of the RESERVE_2 column.
     * @param reserve2
     */
    public void setReserve2(java.lang.String reserve2)
    {
        this.reserve2 = reserve2;
    }

    /**
     * Return the value of the RESERVE_3 column.
     * @return java.lang.String
     */
    public java.lang.String getReserve3()
    {
        return this.reserve3;
    }

    /**
     * Set the value of the RESERVE_3 column.
     * @param reserve3
     */
    public void setReserve3(java.lang.String reserve3)
    {
        this.reserve3 = reserve3;
    }

    /**
     * Return the value of the COMMENTS column.
     * @return java.lang.String
     */
    public java.lang.String getComments()
    {
        return this.comments;
    }

    /**
     * Set the value of the COMMENTS column.
     * @param comments
     */
    public void setComments(java.lang.String comments)
    {
        this.comments = comments;
    }

    /**
     * Return the value of the DEPOSIT_BALA column.
     * @return java.lang.Double
     */
    public java.lang.Double getDepositBala()
    {
        return this.depositBala;
    }

    /**
     * Set the value of the DEPOSIT_BALA column.
     * @param depositBala
     */
    public void setDepositBala(java.lang.Double depositBala)
    {
        this.depositBala = depositBala;
    }

    /**
     * Implementation of the equals comparison on the basis of equality of the primary key values.
     * @param rhs
     * @return boolean
     */
    public boolean equals(Object rhs)
    {
        if (rhs == null)
            return false;
        if (! (rhs instanceof TAifAccount))
            return false;
        TAifAccount that = (TAifAccount) rhs;
        if (this.getAccountId() == null || that.getAccountId() == null)
            return false;
        return (this.getAccountId().equals(that.getAccountId()));
    }

    /**
     * Implementation of the hashCode method conforming to the Bloch pattern with
     * the exception of array properties (these are very unlikely primary key types).
     * @return int
     */
    public int hashCode()
    {
        if (this.hashValue == 0)
        {
            int result = 17;
            int accountIdValue = this.getAccountId() == null ? 0 : this.getAccountId().hashCode();
            result = result * 37 + accountIdValue;
            this.hashValue = result;
        }
        return this.hashValue;
    }
}