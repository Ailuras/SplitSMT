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

(declare-sort var1001 0)
(declare-sort var1011 0)
(declare-sort var963 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var1001 String String) String)
(declare-fun var963_isEmpty/-813097145 (String) Bool)
(declare-fun Float64_parseDouble/1471110886 (String) Float64)
(declare-const null-var1001 var1001)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var1704 var1001) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1704 null-var1001)))
(declare-const var3802 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3802 null-String)))
(declare-const var601 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var601 null-String)))
(declare-const var2212 Float64) ; Statement: d1 := @parameter2: double 
(assert (not (= var2212 null-Float64)))
(assert true)
(define-const var3524 String (getMethodParameter/2015795402 var1704 var3802 var601)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3510 Bool (var963_isEmpty/-813097145 var3524)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3) 
(assert (= (ite var3510 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3160 Float64 (Float64_parseDouble/1471110886 var3524)) ; Statement: $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3) 
 ; Statement: return $d0 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var963_isEmpty/-813097145=([java.lang.String], boolean), Float64_parseDouble/1471110886=([java.lang.String], double)}
; {var1001=org.apache.dubbo.common.URL, var1704=r0, var3802=r1, var1011=null_type, var601=r2, var2212=d1, var3524=r3, var963=org.apache.dubbo.common.utils.StringUtils, var3510=$z0, var3160=$d0}
; {org.apache.dubbo.common.URL=var1001, r0=var1704, r1=var3802, null_type=var1011, r2=var601, d1=var2212, r3=var3524, org.apache.dubbo.common.utils.StringUtils=var963, $z0=var3510, $d0=var3160}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	d1 := @parameter2: double;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3);	$d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r3);	return $d0
;block_num 2