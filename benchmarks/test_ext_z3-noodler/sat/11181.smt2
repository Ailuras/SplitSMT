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

(declare-sort var2314 0)
(declare-sort var2058 0)
(declare-sort var3092 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getVersion/189836348 (var2314) String)
(declare-fun var3092_isEmpty/-813097145 (String) Bool)
(declare-const null-var2314 var2314)
(declare-const null-String String)
(declare-const var467 var2314) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var467 null-var2314)))
(declare-const var3294 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3294 null-String)))
(assert true)
(define-const var3483 String (getVersion/189836348 var467)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var3320 Bool (var3092_isEmpty/-813097145 var3483)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (= (ite var3320 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1812 String var3483) ; Statement: $r3 = r1 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), var3092_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2314=org.apache.dubbo.common.URL, var467=r0, var3294=r2, var2058=null_type, var3483=r1, var3092=org.apache.dubbo.common.utils.StringUtils, var3320=$z0, var1812=$r3}
; {org.apache.dubbo.common.URL=var2314, r0=var467, r2=var3294, null_type=var2058, r1=var3483, org.apache.dubbo.common.utils.StringUtils=var3092, $z0=var3320, $r3=var1812}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r1;	return $r3
;block_num 3