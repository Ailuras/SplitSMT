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

(declare-sort var326 0)
(declare-sort var1958 0)
(declare-sort var3344 0)
(declare-sort var1772 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var326 String) String)
(declare-fun var1772_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var326 var326)
(declare-const null-var1958 var1958)
(declare-const null-String String)
(declare-const var2489 var326) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2489 null-var326)))
(declare-const var478 var1958) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var478 null-var1958)))
(declare-const var125 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var125 null-String)))
(assert true)
(define-const var2059 String (getParameter/-1307325648 var2489 var125)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2764 Bool (var1772_isNotEmpty/-1251449450 var2059)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2764 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1772_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var326=org.apache.dubbo.common.URL, var2489=r0, var1958=java.util.Properties, var478=r3, var125=r1, var3344=null_type, var2059=r2, var1772=org.apache.dubbo.common.utils.StringUtils, var2764=$z0}
; {org.apache.dubbo.common.URL=var326, r0=var2489, java.util.Properties=var1958, r3=var478, r1=var125, null_type=var3344, r2=var2059, org.apache.dubbo.common.utils.StringUtils=var1772, $z0=var2764}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto return;	return
;block_num 2