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

(declare-sort var466 0)
(declare-sort var768 0)
(declare-sort var863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameterAndDecoded/384969937 (var466 String) String)
(declare-fun var863_isEmpty/-813097145 (String) Bool)
(declare-fun var466_valueOf/-778994652 (String) var466)
(declare-const null-var466 var466)
(declare-const null-String String)
(declare-const var1052 var466) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1052 null-var466)))
(declare-const var3195 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3195 null-String)))
(assert true)
(define-const var3745 String (getParameterAndDecoded/384969937 var1052 var3195)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>(r1) 
(define-const var3723 Bool (var863_isEmpty/-813097145 var3745)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>(r2) 
(assert (= (ite var3723 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2091 var466 (var466_valueOf/-778994652 var3745)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>(r2) 
 ; Statement: return $r3 
(check-sat)
; {getParameterAndDecoded/384969937=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var863_isEmpty/-813097145=([java.lang.String], boolean), var466_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL)}
; {var466=org.apache.dubbo.common.URL, var1052=r0, var3195=r1, var768=null_type, var3745=r2, var863=org.apache.dubbo.common.utils.StringUtils, var3723=$z0, var2091=$r3}
; {org.apache.dubbo.common.URL=var466, r0=var1052, r1=var3195, null_type=var768, r2=var3745, org.apache.dubbo.common.utils.StringUtils=var863, $z0=var3723, $r3=var2091}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>(r2);	$r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>(r2);	return $r3
;block_num 2