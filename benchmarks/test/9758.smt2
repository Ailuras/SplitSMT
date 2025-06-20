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

(declare-sort var3201 0)
(declare-sort var3845 0)
(declare-sort var408 0)
(declare-sort var2024 0)
(declare-sort var3748 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3201 String) String)
(declare-fun var2024_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setProperty/703705272 (var3845 String String) var3748)
(declare-const null-var3201 var3201)
(declare-const null-var3845 var3845)
(declare-const null-String String)
(declare-const var2990 var3201) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2990 null-var3201)))
(declare-const var3213 var3845) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var3213 null-var3845)))
(declare-const var777 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var777 null-String)))
(declare-const var1365 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var1365 null-String)))
(assert true)
(define-const var3593 String (getParameter/-1307325648 var2990 var777)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1098 Bool (var2024_isNotEmpty/-1251449450 var3593)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4) 
(assert (= (ite var1098 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (setProperty/703705272 var3213 var777 var1365)) ; Statement: virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4) 

(declare-const var3213!1 var3845)
(declare-const var777!1 String)
(declare-const var1365!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2024_isNotEmpty/-1251449450=([java.lang.String], boolean), setProperty/703705272=([java.util.Properties, java.lang.String, java.lang.String], java.lang.Object)}
; {var3201=org.apache.dubbo.common.URL, var2990=r0, var3845=java.util.Properties, var3213=r3, var777=r1, var408=null_type, var1365=r4, var3593=r2, var2024=org.apache.dubbo.common.utils.StringUtils, var1098=$z0, var3748=java.lang.Object}
; {org.apache.dubbo.common.URL=var3201, r0=var2990, java.util.Properties=var3845, r3=var3213, r1=var777, null_type=var408, r4=var1365, r2=var3593, org.apache.dubbo.common.utils.StringUtils=var2024, $z0=var1098, java.lang.Object=var3748}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r4 := @parameter3: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4);	virtualinvoke r3.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r4);	return
;block_num 3