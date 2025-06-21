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

(declare-sort var3641 0)
(declare-sort var2382 0)
(declare-sort var448 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var3641 String String) String)
(declare-fun var448_isEmpty/-813097145 (String) Bool)
(declare-fun Float64_parseDouble/1471110886 (String) Float64)
(declare-const null-var3641 var3641)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var1677 var3641) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1677 null-var3641)))
(declare-const var946 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var946 null-String)))
(declare-const var2145 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2145 null-String)))
(declare-const var3568 Float64) ; Statement: d1 := @parameter2: double 
(assert (not (= var3568 null-Float64)))
(assert true)
(define-const var1369 String (getServiceParameter/1782298180 var1677 var946 var2145)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1610 Bool (var448_isEmpty/-813097145 var1369)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3) 
(assert (= (ite var1610 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1074 Float64 (Float64_parseDouble/1471110886 var1369)) ; Statement: $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3) 
 ; Statement: return $d0 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var448_isEmpty/-813097145=([java.lang.String], boolean), Float64_parseDouble/1471110886=([java.lang.String], double)}
; {var3641=org.apache.dubbo.common.URL, var1677=r0, var946=r1, var2382=null_type, var2145=r2, var3568=d1, var1369=r3, var448=org.apache.dubbo.common.utils.StringUtils, var1610=$z0, var1074=$d0}
; {org.apache.dubbo.common.URL=var3641, r0=var1677, r1=var946, null_type=var2382, r2=var2145, d1=var3568, r3=var1369, org.apache.dubbo.common.utils.StringUtils=var448, $z0=var1610, $d0=var1074}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	d1 := @parameter2: double;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3);	$d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3);	return $d0
;block_num 2