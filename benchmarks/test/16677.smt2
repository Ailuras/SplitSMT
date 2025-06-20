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

(declare-sort var3624 0)
(declare-sort var194 0)
(declare-sort var2393 0)
(declare-sort var3467 0)
(declare-sort var631 0)
(declare-sort var483 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3467-init () var3467)
(declare-fun var631_toString/2086998539 (String var483) String)
(declare-fun cast-from-var2393-to-var483 (var2393) var483)
(declare-fun <init>/-1557872005 (var3467 String) void)
(declare-const null-var3624 var3624)
(declare-const null-var194 var194)
(declare-const null-var2393 var2393)
(declare-const var221 var3624) ; Statement: r5 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec 
(assert (not (= var221 null-var3624)))
(declare-const var3775 var194) ; Statement: r0 := @parameter0: org.apache.dubbo.common.serialize.ObjectInput 
(assert (not (= var3775 null-var194)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1021 var2393) ; Statement: $r2 := @caughtexception 
(assert (not (= var1021 null-var2393)))
(define-const var890 var3467 var3467-init) ; Statement: $r3 = new java.io.IOException 
(define-const var2543 String (var631_toString/2086998539 "Read object failed." (cast-from-var2393-to-var483 var1021))) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Read object failed.", $r2) 
(assert true)
;(assert (<init>/-1557872005 var890 var2543)) ; Statement: specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r4) 

(declare-const var890!1 var3467)
(declare-const var2543!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var3467-init=([], java.io.IOException), var631_toString/2086998539=([java.lang.String, java.lang.Throwable], java.lang.String), cast-from-var2393-to-var483=([java.lang.ClassNotFoundException], java.lang.Throwable), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var3624=org.apache.dubbo.remoting.exchange.codec.ExchangeCodec, var221=r5, var194=org.apache.dubbo.common.serialize.ObjectInput, var3775=r0, var2393=java.lang.ClassNotFoundException, var1021=$r2, var3467=java.io.IOException, var890=$r3, var631=org.apache.dubbo.common.utils.StringUtils, var483=java.lang.Throwable, var2543=$r4}
; {org.apache.dubbo.remoting.exchange.codec.ExchangeCodec=var3624, r5=var221, org.apache.dubbo.common.serialize.ObjectInput=var194, r0=var3775, java.lang.ClassNotFoundException=var2393, $r2=var1021, java.io.IOException=var3467, $r3=var890, org.apache.dubbo.common.utils.StringUtils=var631, java.lang.Throwable=var483, $r4=var2543}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>": 1}
;stmts r5 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec;	r0 := @parameter0: org.apache.dubbo.common.serialize.ObjectInput;	$r2 := @caughtexception;	$r3 = new java.io.IOException;	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Read object failed.", $r2);	specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r4);	throw $r3
;block_num 2