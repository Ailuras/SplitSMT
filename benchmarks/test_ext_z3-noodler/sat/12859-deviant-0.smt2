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

(declare-sort var3001 0)
(declare-sort var1030 0)
(declare-sort var2435 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var3001 String String) String)
(declare-fun var2435_isEmpty/-813097145 (String) Bool)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-const null-var3001 var3001)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2047 var3001) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2047 null-var3001)))
(declare-const var3678 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3678 null-String)))
(declare-const var1958 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1958 null-String)))
(declare-const var1977 Int) ; Statement: c0 := @parameter2: char 
(assert (not (= var1977 null-Int)))
(assert true)
(define-const var1976 String (getServiceParameter/1782298180 var2047 var3678 var1958)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1115 Bool (var2435_isEmpty/-813097145 var1976)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0) 
(assert (= (ite var1115 1 0) 0)) ; Cond: $z0 == 0 
(assert (not (and true (and (> (str.len var1976) 0) (<= 0 0)))))
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2435_isEmpty/-813097145=([java.lang.String], boolean), charAt/698050440=([java.lang.String, int], char)}
; {var3001=org.apache.dubbo.common.URL, var2047=r0, var3678=r1, var1030=null_type, var1958=r2, var1977=c0, var1976=r3, var2435=org.apache.dubbo.common.utils.StringUtils, var1115=$z0, var1527=$c1}
; {org.apache.dubbo.common.URL=var3001, r0=var2047, r1=var3678, null_type=var1030, r2=var1958, c0=var1977, r3=var1976, org.apache.dubbo.common.utils.StringUtils=var2435, $z0=var1115, $c1=var1527}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.String: char charAt(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	c0 := @parameter2: char;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0);	$c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0);	return $c1
;block_num 3