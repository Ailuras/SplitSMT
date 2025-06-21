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

(declare-sort var1215 0)
(declare-sort var677 0)
(declare-sort var2092 0)
(declare-sort var170 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1215 String) String)
(declare-fun var170_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1215 var1215)
(declare-const null-var677 var677)
(declare-const null-String String)
(declare-const var3369 var1215) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3369 null-var1215)))
(declare-const var3450 var677) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var3450 null-var677)))
(declare-const var1379 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var1379 null-String)))
(assert true)
(define-const var3407 String (getParameter/-1307325648 var3369 var1379)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3025 Bool (var170_isNotEmpty/-1251449450 var3407)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3025 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var170_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1215=org.apache.dubbo.common.URL, var3369=r0, var677=java.util.Properties, var3450=r3, var1379=r1, var2092=null_type, var3407=r2, var170=org.apache.dubbo.common.utils.StringUtils, var3025=$z0}
; {org.apache.dubbo.common.URL=var1215, r0=var3369, java.util.Properties=var677, r3=var3450, r1=var1379, null_type=var2092, r2=var3407, org.apache.dubbo.common.utils.StringUtils=var170, $z0=var3025}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto return;	return
;block_num 2