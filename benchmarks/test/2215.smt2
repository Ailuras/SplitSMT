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

(declare-sort var742 0)
(declare-sort var3908 0)
(declare-sort var3939 0)
(declare-sort var1236 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3939_isEmpty/-813097145 (String) Bool)
(declare-fun var1236_encode/1794151917 (String) String)
(declare-fun addParameter/1929860173 (var742 String String) var742)
(declare-const null-var742 var742)
(declare-const null-String String)
(declare-const var3990 var742) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3990 null-var742)))
(declare-const var933 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var933 null-String)))
(declare-const var3123 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3123 null-String)))
(define-const var678 Bool (var3939_isEmpty/-813097145 var3123)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert (= (ite var678 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1609 String (var1236_encode/1794151917 var3123)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert true)
(define-const var2567 var742 (addParameter/1929860173 var3990 var933 var1609)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {var3939_isEmpty/-813097145=([java.lang.String], boolean), var1236_encode/1794151917=([java.lang.String], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var742=org.apache.dubbo.common.URLBuilder, var3990=r1, var933=r2, var3908=null_type, var3123=r0, var3939=org.apache.dubbo.common.utils.StringUtils, var678=$z0, var1236=org.apache.dubbo.common.URL, var1609=$r3, var2567=$r4}
; {org.apache.dubbo.common.URLBuilder=var742, r1=var3990, r2=var933, null_type=var3908, r0=var3123, org.apache.dubbo.common.utils.StringUtils=var3939, $z0=var678, org.apache.dubbo.common.URL=var1236, $r3=var1609, $r4=var2567}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	$r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2