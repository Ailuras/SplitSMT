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

(declare-sort var2988 0)
(declare-sort var3773 0)
(declare-sort var925 0)
(declare-sort var2941 0)
(declare-sort var489 0)
(declare-sort var1377 0)
(declare-sort var2877 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var2941_bytes2long/-652030811 ((Array Int Int) Int) Int)
(declare-fun var489-init () var489)
(declare-fun <init>/-342160724 (var489 Int) void)
(declare-fun setStatus/-969168820 (var489 Int) void)
(declare-fun var2877_toString/-109309168 (var1377) String)
(declare-fun setErrorMessage/1202863900 (var489 String) void)
(declare-const null-var2988 var2988)
(declare-const null-var3773 var3773)
(declare-const null-var925 var925)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-var1377 var1377)
(declare-const var2858 var2988) ; Statement: r2 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec 
(assert (not (= var2858 null-var2988)))
(declare-const var89 var3773) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var89 null-var3773)))
(declare-const var674 var925) ; Statement: r4 := @parameter1: java.io.InputStream 
(assert (not (= var674 null-var925)))
(declare-const var943 (Array Int Int)) ; Statement: r0 := @parameter2: byte[] 
(assert (not (= var943 null-__Array__Int__Int__)))
(define-const var2918 Int (select var943 2)) ; Statement: b0 = r0[2] 
(define-const var3537 Int (bv2nat (bvand ((_ int2bv 64) var2918) ((_ int2bv 64) 31)))) ; Statement: $b1 = b0 & 31 
(define-const var3740 Int (cast-from-Int-to-Int var3537)) ; Statement: b2 = (byte) $b1 
(define-const var2170 Int (var2941_bytes2long/-652030811 var943 4)) ; Statement: l3 = staticinvoke <org.apache.dubbo.common.io.Bytes: long bytes2long(byte[],int)>(r0, 4) 
(define-const var3280 Int (bv2nat (bvand ((_ int2bv 64) var2918) ((_ int2bv 64) -128)))) ; Statement: $b4 = b0 & -128 
 ; Statement: if $b4 != 0 goto $b5 = b0 & 32 
(assert (not (not (= var3280 0)))) ; Negate: Cond: $b4 != 0  
(define-const var1106 var489 var489-init) ; Statement: $r34 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
;(assert (<init>/-342160724 var1106 var2170)) ; Statement: specialinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void <init>(long)>(l3) 

(declare-const var1106!1 var489)
(declare-const var2170!1 Int)
(define-const var1908 Int (bv2nat (bvand ((_ int2bv 64) var2918) ((_ int2bv 64) 32)))) ; Statement: $b7 = b0 & 32 
 ; Statement: if $b7 == 0 goto $b8 = r0[3] 
(assert (= var1908 0)) ; Cond: $b7 == 0 
(define-const var1204 Int (select var943 3)) ; Statement: $b8 = r0[3] 
(assert true)
;(assert (setStatus/-969168820 var1106!1 var1204)) ; Statement: virtualinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>($b8) 

(declare-const var1106!2 var489)
(declare-const var1204!1 Int)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var15 var1377) ; Statement: $r28 := @caughtexception 
(assert (not (= var15 null-var1377)))
(assert true)
;(assert (setStatus/-969168820 var1106!2 90)) ; Statement: virtualinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(90) 

(declare-const var1106!3 var489)
(declare-const var319 Int)
(define-const var2507 String (var2877_toString/-109309168 var15)) ; Statement: $r29 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r28) 
(assert true)
;(assert (setErrorMessage/1202863900 var1106!3 var2507)) ; Statement: virtualinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r29) 

(declare-const var1106!4 var489)
(declare-const var2507!1 String)
(assert true) ; Non Conditional
 ; Statement: return $r34 
(check-sat)
; {cast-from-Int-to-Int=([byte], byte), var2941_bytes2long/-652030811=([byte[], int], long), var489-init=([], org.apache.dubbo.remoting.exchange.Response), <init>/-342160724=([org.apache.dubbo.remoting.exchange.Response, long], void), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), var2877_toString/-109309168=([java.lang.Throwable], java.lang.String), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void)}
; {var2988=org.apache.dubbo.remoting.exchange.codec.ExchangeCodec, var2858=r2, var3773=org.apache.dubbo.remoting.Channel, var89=r3, var925=java.io.InputStream, var674=r4, var943=r0, var2918=b0, var3537=$b1, var3740=b2, var2941=org.apache.dubbo.common.io.Bytes, var2170=l3, var3280=$b4, var489=org.apache.dubbo.remoting.exchange.Response, var1106=$r34, var1908=$b7, var1204=$b8, var1377=java.lang.Throwable, var15=$r28, var319=90, var2877=org.apache.dubbo.common.utils.StringUtils, var2507=$r29}
; {org.apache.dubbo.remoting.exchange.codec.ExchangeCodec=var2988, r2=var2858, org.apache.dubbo.remoting.Channel=var3773, r3=var89, java.io.InputStream=var925, r4=var674, r0=var943, b0=var2918, $b1=var3537, b2=var3740, org.apache.dubbo.common.io.Bytes=var2941, l3=var2170, $b4=var3280, org.apache.dubbo.remoting.exchange.Response=var489, $r34=var1106, $b7=var1908, $b8=var1204, java.lang.Throwable=var1377, $r28=var15, 90=var319, org.apache.dubbo.common.utils.StringUtils=var2877, $r29=var2507}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>": 1}
;stmts r2 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r4 := @parameter1: java.io.InputStream;	r0 := @parameter2: byte[];	b0 = r0[2];	$b1 = b0 & 31;	b2 = (byte) $b1;	l3 = staticinvoke <org.apache.dubbo.common.io.Bytes: long bytes2long(byte[],int)>(r0, 4);	$b4 = b0 & -128;	if $b4 != 0 goto $b5 = b0 & 32;	$r34 = new org.apache.dubbo.remoting.exchange.Response;	specialinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void <init>(long)>(l3);	$b7 = b0 & 32;	if $b7 == 0 goto $b8 = r0[3];	$b8 = r0[3];	virtualinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>($b8);	$r28 := @caughtexception;	virtualinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(90);	$r29 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r28);	virtualinvoke $r34.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r29);	return $r34
;block_num 5