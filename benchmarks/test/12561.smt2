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

(declare-sort var1545 0)
(declare-sort var3179 0)
(declare-sort var3170 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var1545 String String) String)
(declare-fun var3170_isEmpty/-813097145 (String) Bool)
(declare-const null-var1545 var1545)
(declare-const null-String String)
(declare-const var2748 var1545) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2748 null-var1545)))
(declare-const var2951 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2951 null-String)))
(declare-const var3127 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3127 null-String)))
(declare-const var1153 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var1153 null-String)))
(assert true)
(define-const var2496 String (getServiceParameter/1782298180 var2748 var2951 var3127)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2191 Bool (var3170_isEmpty/-813097145 var2496)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (= (ite var2191 1 0) 0)) ; Cond: $z0 == 0 
(define-const var682 String var2496) ; Statement: $r5 = r3 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3170_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1545=org.apache.dubbo.common.URL, var2748=r0, var2951=r1, var3179=null_type, var3127=r2, var1153=r4, var2496=r3, var3170=org.apache.dubbo.common.utils.StringUtils, var2191=$z0, var682=$r5}
; {org.apache.dubbo.common.URL=var1545, r0=var2748, r1=var2951, null_type=var3179, r2=var3127, r4=var1153, r3=var2496, org.apache.dubbo.common.utils.StringUtils=var3170, $z0=var2191, $r5=var682}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r5 = r3;	$r5 = r3;	return $r5
;block_num 3