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

(declare-sort var99 0)
(declare-sort var369 0)
(declare-sort var1391 0)
(declare-sort var1996 0)
(declare-sort var3943 0)
(declare-sort var475 0)
(declare-sort var3851 0)
(declare-sort var2112 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1996_bytes2long/-652030811 ((Array Int Int) Int) Int)
(declare-fun var475-init () var475)
(declare-fun <init>/1214537574 (var475 Int) void)
(declare-fun setBroken/1387970123 (var475 Bool) void)
(declare-fun setData/895466661 (var475 var3851) void)
(declare-fun cast-from-var3943-to-var3851 (var3943) var3851)
(declare-fun var2112_getProtocolVersion/-704142115 () String)
(declare-fun setVersion/-391222293 (var475 String) void)
(declare-fun setTwoWay/-1793719815 (var475 Bool) void)
(declare-const null-var99 var99)
(declare-const null-var369 var369)
(declare-const null-var1391 var1391)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-var3943 var3943)
(declare-const var2355 var99) ; Statement: r2 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec 
(assert (not (= var2355 null-var99)))
(declare-const var1571 var369) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1571 null-var369)))
(declare-const var3651 var1391) ; Statement: r4 := @parameter1: java.io.InputStream 
(assert (not (= var3651 null-var1391)))
(declare-const var1957 (Array Int Int)) ; Statement: r0 := @parameter2: byte[] 
(assert (not (= var1957 null-__Array__Int__Int__)))
(define-const var98 Int (select var1957 2)) ; Statement: b0 = r0[2] 
(define-const var1070 Int (bv2nat (bvand ((_ int2bv 64) var98) ((_ int2bv 64) 31)))) ; Statement: $b1 = b0 & 31 
(define-const var3627 Int (cast-from-Int-to-Int var1070)) ; Statement: b2 = (byte) $b1 
(define-const var1328 Int (var1996_bytes2long/-652030811 var1957 4)) ; Statement: l3 = staticinvoke <org.apache.dubbo.common.io.Bytes: long bytes2long(byte[],int)>(r0, 4) 
(define-const var1972 Int (bv2nat (bvand ((_ int2bv 64) var98) ((_ int2bv 64) -128)))) ; Statement: $b4 = b0 & -128 
 ; Statement: if $b4 != 0 goto $b5 = b0 & 32 
(assert (not (not (= var1972 0)))) ; Negate: Cond: $b4 != 0  
(declare-const var2408 var3943) ; Statement: $r26 := @caughtexception 
(assert (not (= var2408 null-var3943)))
(define-const var2322 var475 var475-init) ; Statement: $r40 = new org.apache.dubbo.remoting.exchange.Request 
(assert true)
;(assert (<init>/1214537574 var2322 var1328)) ; Statement: specialinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void <init>(long)>(l3) 

(declare-const var2322!1 var475)
(declare-const var1328!1 Int)
(define-const var815 var475 var2322!1) ; Statement: r32 = $r40 
(assert true)
;(assert (setBroken/1387970123 var2322!1 (ite (= 1 1) true false))) ; Statement: virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setBroken(boolean)>(1) 

(declare-const var2322!2 var475)
(declare-const var2251 Int)
(assert true)
;(assert (setData/895466661 var2322!2 (cast-from-var3943-to-var3851 var2408))) ; Statement: virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setData(java.lang.Object)>($r26) 

(declare-const var2322!3 var475)
(declare-const var2408!1 var3943)
(assert true) ; Non Conditional
(define-const var1806 String var2112_getProtocolVersion/-704142115) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getProtocolVersion()>() 
(assert true)
;(assert (setVersion/-391222293 var815 var1806)) ; Statement: virtualinvoke r32.<org.apache.dubbo.remoting.exchange.Request: void setVersion(java.lang.String)>($r7) 

(declare-const var815!1 var475)
(declare-const var1806!1 String)
(define-const var1794 var475 var815!1) ; Statement: $r8 = r32 
(define-const var899 Int (bv2nat (bvand ((_ int2bv 64) var98) ((_ int2bv 64) 64)))) ; Statement: $b6 = b0 & 64 
 ; Statement: if $b6 == 0 goto $z3 = 0 
(assert (= var899 0)) ; Cond: $b6 == 0 
(define-const var3846 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
(assert true)
;(assert (setTwoWay/-1793719815 var1794 var3846)) ; Statement: virtualinvoke $r8.<org.apache.dubbo.remoting.exchange.Request: void setTwoWay(boolean)>($z3) 

(declare-const var1794!1 var475)
(declare-const var3846!1 Bool)
 ; Statement: return r32 
(check-sat)
; {cast-from-Int-to-Int=([byte], byte), var1996_bytes2long/-652030811=([byte[], int], long), var475-init=([], org.apache.dubbo.remoting.exchange.Request), <init>/1214537574=([org.apache.dubbo.remoting.exchange.Request, long], void), setBroken/1387970123=([org.apache.dubbo.remoting.exchange.Request, boolean], void), setData/895466661=([org.apache.dubbo.remoting.exchange.Request, java.lang.Object], void), cast-from-var3943-to-var3851=([java.lang.Throwable], java.lang.Object), var2112_getProtocolVersion/-704142115=([], java.lang.String), setVersion/-391222293=([org.apache.dubbo.remoting.exchange.Request, java.lang.String], void), setTwoWay/-1793719815=([org.apache.dubbo.remoting.exchange.Request, boolean], void)}
; {var99=org.apache.dubbo.remoting.exchange.codec.ExchangeCodec, var2355=r2, var369=org.apache.dubbo.remoting.Channel, var1571=r3, var1391=java.io.InputStream, var3651=r4, var1957=r0, var98=b0, var1070=$b1, var3627=b2, var1996=org.apache.dubbo.common.io.Bytes, var1328=l3, var1972=$b4, var3943=java.lang.Throwable, var2408=$r26, var475=org.apache.dubbo.remoting.exchange.Request, var2322=$r40, var815=r32, var2251=1, var3851=java.lang.Object, var2112=org.apache.dubbo.common.Version, var1806=$r7, var1794=$r8, var899=$b6, var3846=$z3}
; {org.apache.dubbo.remoting.exchange.codec.ExchangeCodec=var99, r2=var2355, org.apache.dubbo.remoting.Channel=var369, r3=var1571, java.io.InputStream=var1391, r4=var3651, r0=var1957, b0=var98, $b1=var1070, b2=var3627, org.apache.dubbo.common.io.Bytes=var1996, l3=var1328, $b4=var1972, java.lang.Throwable=var3943, $r26=var2408, org.apache.dubbo.remoting.exchange.Request=var475, $r40=var2322, r32=var815, 1=var2251, java.lang.Object=var3851, org.apache.dubbo.common.Version=var2112, $r7=var1806, $r8=var1794, $b6=var899, $z3=var3846}
;seq 
;cnt {}
;stmts r2 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r4 := @parameter1: java.io.InputStream;	r0 := @parameter2: byte[];	b0 = r0[2];	$b1 = b0 & 31;	b2 = (byte) $b1;	l3 = staticinvoke <org.apache.dubbo.common.io.Bytes: long bytes2long(byte[],int)>(r0, 4);	$b4 = b0 & -128;	if $b4 != 0 goto $b5 = b0 & 32;	$r26 := @caughtexception;	$r40 = new org.apache.dubbo.remoting.exchange.Request;	specialinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void <init>(long)>(l3);	r32 = $r40;	virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setBroken(boolean)>(1);	virtualinvoke $r40.<org.apache.dubbo.remoting.exchange.Request: void setData(java.lang.Object)>($r26);	$r7 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getProtocolVersion()>();	virtualinvoke r32.<org.apache.dubbo.remoting.exchange.Request: void setVersion(java.lang.String)>($r7);	$r8 = r32;	$b6 = b0 & 64;	if $b6 == 0 goto $z3 = 0;	$z3 = 0;	virtualinvoke $r8.<org.apache.dubbo.remoting.exchange.Request: void setTwoWay(boolean)>($z3);	return r32
;block_num 5