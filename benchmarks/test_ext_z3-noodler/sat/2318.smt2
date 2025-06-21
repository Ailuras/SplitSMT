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

(declare-sort var1254 0)
(declare-sort var3454 0)
(declare-sort var2630 0)
(declare-sort var719 0)
(declare-sort var1041 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3454_isEmpty/-813097145 (String) Bool)
(declare-fun var719-init () var719)
(declare-fun getMessage/849299655 (var1041) String)
(declare-fun cast-from-var2630-to-var1041 (var2630) var1041)
(declare-fun <init>/1642269841 (var719 String var1041) void)
(declare-const null-String String)
(declare-const null-var2630 var2630)
(declare-const var350 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var350 null-String)))
(define-const var394 Bool (var3454_isEmpty/-813097145 var350)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <java.net.URLDecoder: java.lang.String decode(java.lang.String,java.lang.String)>(r0, "UTF-8") 
(assert (not (= (ite var394 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var3822 var2630) ; Statement: $r2 := @caughtexception 
(assert (not (= var3822 null-var2630)))
(define-const var3475 var719 var719-init) ; Statement: $r3 = new java.lang.RuntimeException 
(assert true)
(define-const var463 String (getMessage/849299655 (cast-from-var2630-to-var1041 var3822))) ; Statement: $r4 = virtualinvoke $r2.<java.io.UnsupportedEncodingException: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/1642269841 var3475 var463 (cast-from-var2630-to-var1041 var3822))) ; Statement: specialinvoke $r3.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r4, $r2) 

(declare-const var3475!1 var719)
(declare-const var463!1 String)
(declare-const var3822!1 var2630)
 ; Statement: throw $r3 
(check-sat)
; {var3454_isEmpty/-813097145=([java.lang.String], boolean), var719-init=([], java.lang.RuntimeException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2630-to-var1041=([java.io.UnsupportedEncodingException], java.lang.Throwable), <init>/1642269841=([java.lang.RuntimeException, java.lang.String, java.lang.Throwable], void)}
; {var350=r0, var1254=null_type, var3454=org.apache.dubbo.common.utils.StringUtils, var394=$z0, var2630=java.io.UnsupportedEncodingException, var3822=$r2, var719=java.lang.RuntimeException, var3475=$r3, var1041=java.lang.Throwable, var463=$r4}
; {r0=var350, null_type=var1254, org.apache.dubbo.common.utils.StringUtils=var3454, $z0=var394, java.io.UnsupportedEncodingException=var2630, $r2=var3822, java.lang.RuntimeException=var719, $r3=var3475, java.lang.Throwable=var1041, $r4=var463}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <java.net.URLDecoder: java.lang.String decode(java.lang.String,java.lang.String)>(r0, "UTF-8");	$r2 := @caughtexception;	$r3 = new java.lang.RuntimeException;	$r4 = virtualinvoke $r2.<java.io.UnsupportedEncodingException: java.lang.String getMessage()>();	specialinvoke $r3.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r4, $r2);	throw $r3
;block_num 2