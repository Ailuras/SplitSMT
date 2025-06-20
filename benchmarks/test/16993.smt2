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

(declare-sort var1657 0)
(declare-sort var2379 0)
(declare-sort var1263 0)
(declare-sort var3687 0)
(declare-sort var334 0)
(declare-sort var821 0)
(declare-sort var1948 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var334-init () var334)
(declare-fun var821_toString/2086998539 (String var1948) String)
(declare-fun cast-from-var3687-to-var1948 (var3687) var1948)
(declare-fun <init>/-1557872005 (var334 String) void)
(declare-const null-var1657 var1657)
(declare-const null-var2379 var2379)
(declare-const null-var1263 var1263)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-var3687 var3687)
(declare-const var1767 var1657) ; Statement: r18 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec 
(assert (not (= var1767 null-var1657)))
(declare-const var3948 var2379) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3948 null-var2379)))
(declare-const var3536 var1263) ; Statement: r1 := @parameter1: org.apache.dubbo.common.serialize.ObjectInput 
(assert (not (= var3536 null-var1263)))
(declare-const var2505 (Array Int Int)) ; Statement: r0 := @parameter2: byte[] 
(assert (not (= var2505 null-__Array__Int__Int__)))
 ; Statement: if r0 == null goto $r2 = interfaceinvoke r1.<org.apache.dubbo.common.serialize.ObjectInput: java.lang.String readEvent()>() 
(assert (not (= var2505 null-__Array__Int__Int__))) ; Negate: Cond: r0 == null  
(declare-const var146 var3687) ; Statement: $r15 := @caughtexception 
(assert (not (= var146 null-var3687)))
(define-const var780 var334 var334-init) ; Statement: $r16 = new java.io.IOException 
(define-const var3880 String (var821_toString/2086998539 "Decode dubbo protocol event failed." (cast-from-var3687-to-var1948 var146))) ; Statement: $r17 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Decode dubbo protocol event failed.", $r15) 
(assert true)
;(assert (<init>/-1557872005 var780 var3880)) ; Statement: specialinvoke $r16.<java.io.IOException: void <init>(java.lang.String)>($r17) 

(declare-const var780!1 var334)
(declare-const var3880!1 String)
 ; Statement: throw $r16 
(check-sat)
; {var334-init=([], java.io.IOException), var821_toString/2086998539=([java.lang.String, java.lang.Throwable], java.lang.String), cast-from-var3687-to-var1948=([java.lang.Exception], java.lang.Throwable), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var1657=org.apache.dubbo.remoting.exchange.codec.ExchangeCodec, var1767=r18, var2379=org.apache.dubbo.remoting.Channel, var3948=r3, var1263=org.apache.dubbo.common.serialize.ObjectInput, var3536=r1, var2505=r0, var3687=java.lang.Exception, var146=$r15, var334=java.io.IOException, var780=$r16, var821=org.apache.dubbo.common.utils.StringUtils, var1948=java.lang.Throwable, var3880=$r17}
; {org.apache.dubbo.remoting.exchange.codec.ExchangeCodec=var1657, r18=var1767, org.apache.dubbo.remoting.Channel=var2379, r3=var3948, org.apache.dubbo.common.serialize.ObjectInput=var1263, r1=var3536, r0=var2505, java.lang.Exception=var3687, $r15=var146, java.io.IOException=var334, $r16=var780, org.apache.dubbo.common.utils.StringUtils=var821, java.lang.Throwable=var1948, $r17=var3880}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>": 1}
;stmts r18 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: org.apache.dubbo.common.serialize.ObjectInput;	r0 := @parameter2: byte[];	if r0 == null goto $r2 = interfaceinvoke r1.<org.apache.dubbo.common.serialize.ObjectInput: java.lang.String readEvent()>();	$r15 := @caughtexception;	$r16 = new java.io.IOException;	$r17 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Decode dubbo protocol event failed.", $r15);	specialinvoke $r16.<java.io.IOException: void <init>(java.lang.String)>($r17);	throw $r16
;block_num 2