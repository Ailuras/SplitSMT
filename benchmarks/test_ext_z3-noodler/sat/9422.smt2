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

(declare-sort var2389 0)
(declare-sort var2750 0)
(declare-sort var1615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2389 String) String)
(declare-fun var1615_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2389 var2389)
(declare-const null-String String)
(declare-const var2196 var2389) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2196 null-var2389)))
(declare-const var731 String) ; Statement: r3 := @parameter0: java.lang.StringBuilder 
(assert (not (= var731 null-String)))
(declare-const var329 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var329 null-String)))
(assert true)
(define-const var146 String (getParameter/-1307325648 var2196 var329)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2896 Bool (var1615_isBlank/-523695098 (cast-from-String-to-String var146))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var2896 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1615_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2389=org.apache.dubbo.common.URL, var2196=r0, var731=r3, var329=r1, var2750=null_type, var146=r2, var1615=org.apache.dubbo.common.utils.StringUtils, var2896=$z0}
; {org.apache.dubbo.common.URL=var2389, r0=var2196, r3=var731, r1=var329, null_type=var2750, r2=var146, org.apache.dubbo.common.utils.StringUtils=var1615, $z0=var2896}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r3 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2);	if $z0 != 0 goto return;	return
;block_num 2