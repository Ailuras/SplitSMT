(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1312 0)
(declare-sort var2989 0)
(declare-sort var27 0)
(declare-sort var513 0)
(declare-sort var775 0)
(declare-sort var1588 0)
(declare-sort var238 0)
(declare-sort var1560 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var513_bytes2long/-652030811 ((Array Int Int) Int) Int)
(declare-fun var1588-init () var1588)
(declare-fun <init>/1214537574 (var1588 Int) void)
(declare-fun setBroken/1387970123 (var1588 Bool) void)
(declare-fun setData/895466661 (var1588 var238) void)
(declare-fun cast-from-var775-to-var238 (var775) var238)
(declare-fun var1560_getProtocolVersion/-704142115 () String)
(declare-fun setVersion/-391222293 (var1588 String) void)
(declare-fun setTwoWay/-1793719815 (var1588 Bool) void)
(declare-const null-var1312 var1312)
(declare-const null-var2989 var2989)
(declare-const null-var27 var27)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-var775 var775)
(declare-const var3728 var1312) ; Statement: r2 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec 
(assert (not (= var3728 null-var1312)))
(declare-const var2598 var2989) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2598 null-var2989)))
(declare-const var3238 var27) ; Statement: r4 := @parameter1: java.io.InputStream 
(assert (not (= var3238 null-var27)))
(declare-const var141 (Array Int Int)) ; Statement: r0 := @parameter2: byte[] 
(assert (not (= var141 null-__Array__Int__Int__)))
(define-const var2688 Int (select var141 2)) ; Statement: b0 = r0[2] 
(define-const var2442 Int (bv2nat (bvand ((_ int2bv 64) var2688) ((_ int2bv 64) 31)))) ; Statement: $b1 = b0 & 31 
(define-const var1496 Int (cast-from-Int-to-Int var2442)) ; Statement: b2 = (byte) $b1 
(define-const var1863 Int (var513_bytes2long/-652030811 var141 4)) ; Statement: l3 = staticinvoke <org.apache.dubbo.common.io.Bytes: long bytes2long(byte[],int)>(r0, 4) 
(define-const var95 Int (bv2nat (bvand ((_ int2bv 64) var2688) ((_ int2bv 64) -128)))) ; Statement: $b4 = b0 & -128 
 ; Statement: if $b4 != 0 goto $b5 = b0 & 32 
(assert (not (not (= var95 0)))) ; Negate: Cond: $b4 != 0  
(declare-const var3284 var775) ; Statement: $r26 := @caughtexception 
(assert (not (= var3284 null-var775)))
(define-const var1674 var1588 var1588-init) ; Statement: $r40 = new org.apache.dubbo.remoting.exchange.Request 
(assert true)
;(assert (<init>/1214537574 var1674 var1863)) ; Statement: specialinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void <init>(long)>(l3) 

(declare-const var1674!1 var1588)
(declare-const var1863!1 Int)
(define-const var3057 var1588 var1674!1) ; Statement: r32 = $r40 
(assert true)
;(assert (setBroken/1387970123 var1674!1 (ite (= 1 1) true false))) ; Statement: virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setBroken(boolean)>(1) 

(declare-const var1674!2 var1588)
(declare-const var3353 Int)
(assert true)
;(assert (setData/895466661 var1674!2 (cast-from-var775-to-var238 var3284))) ; Statement: virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setData(java.lang.Object)>($r26) 

(declare-const var1674!3 var1588)
(declare-const var3284!1 var775)
(assert true) ; Non Conditional
(define-const var390 String var1560_getProtocolVersion/-704142115) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getProtocolVersion()>() 
(assert true)
;(assert (setVersion/-391222293 var3057 var390)) ; Statement: virtualinvoke r32.<org.apache.dubbo.remoting.exchange.Request: void setVersion(java.lang.String)>($r7) 

(declare-const var3057!1 var1588)
(declare-const var390!1 String)
(define-const var510 var1588 var3057!1) ; Statement: $r8 = r32 
(define-const var3919 Int (bv2nat (bvand ((_ int2bv 64) var2688) ((_ int2bv 64) 64)))) ; Statement: $b6 = b0 & 64 
 ; Statement: if $b6 == 0 goto $z3 = 0 
(assert (not (= var3919 0))) ; Negate: Cond: $b6 == 0  
(define-const var2073 Bool (ite (= 1 1) true false)) ; Statement: $z3 = 1 
 ; Statement: goto [?= virtualinvoke $r8.<org.apache.dubbo.remoting.exchange.Request: void setTwoWay(boolean)>($z3)] 
(assert true) ; Non Conditional
(assert true)
;(assert (setTwoWay/-1793719815 var510 var2073)) ; Statement: virtualinvoke $r8.<org.apache.dubbo.remoting.exchange.Request: void setTwoWay(boolean)>($z3) 

(declare-const var510!1 var1588)
(declare-const var2073!1 Bool)
 ; Statement: return r32 
(check-sat)
; {cast-from-Int-to-Int=([byte], byte), var513_bytes2long/-652030811=([byte[], int], long), var1588-init=([], org.apache.dubbo.remoting.exchange.Request), <init>/1214537574=([org.apache.dubbo.remoting.exchange.Request, long], void), setBroken/1387970123=([org.apache.dubbo.remoting.exchange.Request, boolean], void), setData/895466661=([org.apache.dubbo.remoting.exchange.Request, java.lang.Object], void), cast-from-var775-to-var238=([java.lang.Throwable], java.lang.Object), var1560_getProtocolVersion/-704142115=([], java.lang.String), setVersion/-391222293=([org.apache.dubbo.remoting.exchange.Request, java.lang.String], void), setTwoWay/-1793719815=([org.apache.dubbo.remoting.exchange.Request, boolean], void)}
; {var1312=org.apache.dubbo.remoting.exchange.codec.ExchangeCodec, var3728=r2, var2989=org.apache.dubbo.remoting.Channel, var2598=r3, var27=java.io.InputStream, var3238=r4, var141=r0, var2688=b0, var2442=$b1, var1496=b2, var513=org.apache.dubbo.common.io.Bytes, var1863=l3, var95=$b4, var775=java.lang.Throwable, var3284=$r26, var1588=org.apache.dubbo.remoting.exchange.Request, var1674=$r40, var3057=r32, var3353=1, var238=java.lang.Object, var1560=org.apache.dubbo.common.Version, var390=$r7, var510=$r8, var3919=$b6, var2073=$z3}
; {org.apache.dubbo.remoting.exchange.codec.ExchangeCodec=var1312, r2=var3728, org.apache.dubbo.remoting.Channel=var2989, r3=var2598, java.io.InputStream=var27, r4=var3238, r0=var141, b0=var2688, $b1=var2442, b2=var1496, org.apache.dubbo.common.io.Bytes=var513, l3=var1863, $b4=var95, java.lang.Throwable=var775, $r26=var3284, org.apache.dubbo.remoting.exchange.Request=var1588, $r40=var1674, r32=var3057, 1=var3353, java.lang.Object=var238, org.apache.dubbo.common.Version=var1560, $r7=var390, $r8=var510, $b6=var3919, $z3=var2073}
;seq 
;cnt {}
;stmts r2 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r4 := @parameter1: java.io.InputStream;	r0 := @parameter2: byte[];	b0 = r0[2];	$b1 = b0 & 31;	b2 = (byte) $b1;	l3 = staticinvoke <org.apache.dubbo.common.io.Bytes: long bytes2long(byte[],int)>(r0, 4);	$b4 = b0 & -128;	if $b4 != 0 goto $b5 = b0 & 32;	$r26 := @caughtexception;	$r40 = new org.apache.dubbo.remoting.exchange.Request;	specialinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void <init>(long)>(l3);	r32 = $r40;	virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setBroken(boolean)>(1);	virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setData(java.lang.Object)>($r26);	$r7 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getProtocolVersion()>();	virtualinvoke r32.<org.apache.dubbo.remoting.exchange.Request: void setVersion(java.lang.String)>($r7);	$r8 = r32;	$b6 = b0 & 64;	if $b6 == 0 goto $z3 = 0;	$z3 = 1;	goto [?= virtualinvoke $r8.<org.apache.dubbo.remoting.exchange.Request: void setTwoWay(boolean)>($z3)];	virtualinvoke $r8.<org.apache.dubbo.remoting.exchange.Request: void setTwoWay(boolean)>($z3);	return r32
;block_num 5