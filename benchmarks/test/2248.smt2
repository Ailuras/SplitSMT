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

(declare-sort var2985 0)
(declare-sort var3146 0)
(declare-sort var3447 0)
(declare-sort var816 0)
(declare-sort var2588 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3146_isEmpty/-813097145 (String) Bool)
(declare-fun var816-init () var816)
(declare-fun getMessage/849299655 (var2588) String)
(declare-fun cast-from-var3447-to-var2588 (var3447) var2588)
(declare-fun <init>/1642269841 (var816 String var2588) void)
(declare-const null-String String)
(declare-const null-var3447 var3447)
(declare-const var16 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var16 null-String)))
(define-const var3690 Bool (var3146_isEmpty/-813097145 var16)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <java.net.URLEncoder: java.lang.String encode(java.lang.String,java.lang.String)>(r0, "UTF-8") 
(assert (not (= (ite var3690 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var3922 var3447) ; Statement: $r2 := @caughtexception 
(assert (not (= var3922 null-var3447)))
(define-const var1139 var816 var816-init) ; Statement: $r3 = new java.lang.RuntimeException 
(assert true)
(define-const var1830 String (getMessage/849299655 (cast-from-var3447-to-var2588 var3922))) ; Statement: $r4 = virtualinvoke $r2.<java.io.UnsupportedEncodingException: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/1642269841 var1139 var1830 (cast-from-var3447-to-var2588 var3922))) ; Statement: specialinvoke $r3.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r4, $r2) 

(declare-const var1139!1 var816)
(declare-const var1830!1 String)
(declare-const var3922!1 var3447)
 ; Statement: throw $r3 
(check-sat)
; {var3146_isEmpty/-813097145=([java.lang.String], boolean), var816-init=([], java.lang.RuntimeException), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3447-to-var2588=([java.io.UnsupportedEncodingException], java.lang.Throwable), <init>/1642269841=([java.lang.RuntimeException, java.lang.String, java.lang.Throwable], void)}
; {var16=r0, var2985=null_type, var3146=org.apache.dubbo.common.utils.StringUtils, var3690=$z0, var3447=java.io.UnsupportedEncodingException, var3922=$r2, var816=java.lang.RuntimeException, var1139=$r3, var2588=java.lang.Throwable, var1830=$r4}
; {r0=var16, null_type=var2985, org.apache.dubbo.common.utils.StringUtils=var3146, $z0=var3690, java.io.UnsupportedEncodingException=var3447, $r2=var3922, java.lang.RuntimeException=var816, $r3=var1139, java.lang.Throwable=var2588, $r4=var1830}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <java.net.URLEncoder: java.lang.String encode(java.lang.String,java.lang.String)>(r0, "UTF-8");	$r2 := @caughtexception;	$r3 = new java.lang.RuntimeException;	$r4 = virtualinvoke $r2.<java.io.UnsupportedEncodingException: java.lang.String getMessage()>();	specialinvoke $r3.<java.lang.RuntimeException: void <init>(java.lang.String,java.lang.Throwable)>($r4, $r2);	throw $r3
;block_num 2