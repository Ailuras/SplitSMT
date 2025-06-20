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

(declare-sort var1450 0)
(declare-sort var1426 0)
(declare-sort var1247 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1450 String) String)
(declare-fun var1247_isEmpty/-813097145 (String) Bool)
(declare-const null-var1450 var1450)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3996 var1450) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3996 null-var1450)))
(declare-const var406 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var406 null-String)))
(declare-const var3586 Int) ; Statement: s1 := @parameter1: short 
(assert (not (= var3586 null-Int)))
(assert true)
(define-const var540 String (getParameter/-1307325648 var3996 var406)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3115 Bool (var1247_isEmpty/-813097145 var540)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r2) 
(assert (not (= (ite var3115 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return s1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1247_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1450=org.apache.dubbo.common.URL, var3996=r0, var406=r1, var1426=null_type, var3586=s1, var540=r2, var1247=org.apache.dubbo.common.utils.StringUtils, var3115=$z0}
; {org.apache.dubbo.common.URL=var1450, r0=var3996, r1=var406, null_type=var1426, s1=var3586, r2=var540, org.apache.dubbo.common.utils.StringUtils=var1247, $z0=var3115}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	s1 := @parameter1: short;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r2);	return s1
;block_num 2