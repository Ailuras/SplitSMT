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

(declare-sort var3728 0)
(declare-sort var1994 0)
(declare-sort var1230 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1994-to-String (var1994) String)
(declare-fun cap0/-882215417 (var3728) String)
(declare-fun var1230_lambda$encodeParameters$2/1129122482 (String String String) void)
(declare-const null-var3728 var3728)
(declare-const null-var1994 var1994)
(declare-const var3933 var3728) ; Statement: $r0 := @this: org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301 
(assert (not (= var3933 null-var3728)))
(declare-const var399 var1994) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var399 null-var1994)))
(declare-const var510 var1994) ; Statement: $r2 := @parameter1: java.lang.Object 
(assert (not (= var510 null-var1994)))
(define-const var106 String (cast-from-var1994-to-String var399)) ; Statement: $r3 = (java.lang.String) $r1 
(define-const var2555 String (cast-from-var1994-to-String var510)) ; Statement: $r4 = (java.lang.String) $r2 
(define-const var949 String (cap0/-882215417 var3933)) ; Statement: $r5 = $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301: java.lang.StringBuilder cap0> 
;(assert (var1230_lambda$encodeParameters$2/1129122482 var949 var106 var2555)) ; Statement: staticinvoke <org.apache.dubbo.common.utils.StringUtils: void lambda$encodeParameters$2(java.lang.StringBuilder,java.lang.String,java.lang.String)>($r5, $r3, $r4) 

(declare-const var949!1 String)
(declare-const var106!1 String)
(declare-const var2555!1 String)
 ; Statement: return 
(check-sat)
; {cast-from-var1994-to-String=([java.lang.Object], java.lang.String), cap0/-882215417=([org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301], java.lang.StringBuilder), var1230_lambda$encodeParameters$2/1129122482=([java.lang.StringBuilder, java.lang.String, java.lang.String], void)}
; {var3728=org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301, var3933=$r0, var1994=java.lang.Object, var399=$r1, var510=$r2, var106=$r3, var2555=$r4, var949=$r5, var1230=org.apache.dubbo.common.utils.StringUtils}
; {org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301=var3728, $r0=var3933, java.lang.Object=var1994, $r1=var399, $r2=var510, $r3=var106, $r4=var2555, $r5=var949, org.apache.dubbo.common.utils.StringUtils=var1230}
;seq <org.apache.dubbo.common.utils.StringUtils: void lambda$encodeParameters$2(java.lang.StringBuilder,java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: void lambda$encodeParameters$2(java.lang.StringBuilder,java.lang.String,java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301;	$r1 := @parameter0: java.lang.Object;	$r2 := @parameter1: java.lang.Object;	$r3 = (java.lang.String) $r1;	$r4 = (java.lang.String) $r2;	$r5 = $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_encodeParameters_2__301: java.lang.StringBuilder cap0>;	staticinvoke <org.apache.dubbo.common.utils.StringUtils: void lambda$encodeParameters$2(java.lang.StringBuilder,java.lang.String,java.lang.String)>($r5, $r3, $r4);	return
;block_num 1