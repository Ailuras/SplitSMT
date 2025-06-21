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

(declare-sort var2508 0)
(declare-sort var2082 0)
(declare-sort var3156 0)
(declare-sort var801 0)
(declare-sort var1748 0)
(declare-sort var3059 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var801-init () var801)
(declare-fun var1748_toString/2086998539 (String var3059) String)
(declare-fun cast-from-var3156-to-var3059 (var3156) var3059)
(declare-fun <init>/-1557872005 (var801 String) void)
(declare-const null-var2508 var2508)
(declare-const null-var2082 var2082)
(declare-const null-var3156 var3156)
(declare-const var1094 var2508) ; Statement: r5 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec 
(assert (not (= var1094 null-var2508)))
(declare-const var2925 var2082) ; Statement: r0 := @parameter0: org.apache.dubbo.common.serialize.ObjectInput 
(assert (not (= var2925 null-var2082)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2274 var3156) ; Statement: $r2 := @caughtexception 
(assert (not (= var2274 null-var3156)))
(define-const var3476 var801 var801-init) ; Statement: $r3 = new java.io.IOException 
(define-const var682 String (var1748_toString/2086998539 "Read object failed." (cast-from-var3156-to-var3059 var2274))) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Read object failed.", $r2) 
(assert true)
;(assert (<init>/-1557872005 var3476 var682)) ; Statement: specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r4) 

(declare-const var3476!1 var801)
(declare-const var682!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var801-init=([], java.io.IOException), var1748_toString/2086998539=([java.lang.String, java.lang.Throwable], java.lang.String), cast-from-var3156-to-var3059=([java.lang.ClassNotFoundException], java.lang.Throwable), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var2508=org.apache.dubbo.remoting.exchange.codec.ExchangeCodec, var1094=r5, var2082=org.apache.dubbo.common.serialize.ObjectInput, var2925=r0, var3156=java.lang.ClassNotFoundException, var2274=$r2, var801=java.io.IOException, var3476=$r3, var1748=org.apache.dubbo.common.utils.StringUtils, var3059=java.lang.Throwable, var682=$r4}
; {org.apache.dubbo.remoting.exchange.codec.ExchangeCodec=var2508, r5=var1094, org.apache.dubbo.common.serialize.ObjectInput=var2082, r0=var2925, java.lang.ClassNotFoundException=var3156, $r2=var2274, java.io.IOException=var801, $r3=var3476, org.apache.dubbo.common.utils.StringUtils=var1748, java.lang.Throwable=var3059, $r4=var682}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>": 1}
;stmts r5 := @this: org.apache.dubbo.remoting.exchange.codec.ExchangeCodec;	r0 := @parameter0: org.apache.dubbo.common.serialize.ObjectInput;	$r2 := @caughtexception;	$r3 = new java.io.IOException;	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.String,java.lang.Throwable)>("Read object failed.", $r2);	specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r4);	throw $r3
;block_num 2