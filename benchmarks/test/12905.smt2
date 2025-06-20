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

(declare-sort var2369 0)
(declare-sort var1283 0)
(declare-sort var3156 0)
(declare-sort var2070 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var2369 String String) String)
(declare-fun var3156_isEmpty/-813097145 (String) Bool)
(declare-fun var2070_parseBoolean/746105335 (String) Bool)
(declare-const null-var2369 var2369)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var2082 var2369) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2082 null-var2369)))
(declare-const var2335 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2335 null-String)))
(declare-const var3923 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3923 null-String)))
(declare-const var2850 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var2850 null-Bool)))
(assert true)
(define-const var1784 String (getServiceParameter/1782298180 var2082 var2335 var3923)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3405 Bool (var3156_isEmpty/-813097145 var1784)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (= (ite var3405 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1951 Bool (var2070_parseBoolean/746105335 var1784)) ; Statement: $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3156_isEmpty/-813097145=([java.lang.String], boolean), var2070_parseBoolean/746105335=([java.lang.String], boolean)}
; {var2369=org.apache.dubbo.common.URL, var2082=r0, var2335=r1, var1283=null_type, var3923=r2, var2850=z1, var1784=r3, var3156=org.apache.dubbo.common.utils.StringUtils, var3405=$z0, var2070=java.lang.Boolean, var1951=$z2}
; {org.apache.dubbo.common.URL=var2369, r0=var2082, r1=var2335, null_type=var1283, r2=var3923, z1=var2850, r3=var1784, org.apache.dubbo.common.utils.StringUtils=var3156, $z0=var3405, java.lang.Boolean=var2070, $z2=var1951}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	return $z2
;block_num 3