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

(declare-sort var2872 0)
(declare-sort var338 0)
(declare-sort var334 0)
(declare-sort var2774 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var2872 String String) String)
(declare-fun var334_isEmpty/-813097145 (String) Bool)
(declare-fun var2774_parseBoolean/746105335 (String) Bool)
(declare-const null-var2872 var2872)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3686 var2872) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3686 null-var2872)))
(declare-const var230 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var230 null-String)))
(declare-const var1741 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1741 null-String)))
(declare-const var1753 Bool) ; Statement: z2 := @parameter2: boolean 
(assert (not (= var1753 null-Bool)))
(assert true)
(define-const var605 String (getMethodParameter/2069355293 var3686 var230 var1741)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3011 Bool (var334_isEmpty/-813097145 var605)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (= (ite var3011 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3441 Bool (var2774_parseBoolean/746105335 var605)) ; Statement: $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
 ; Statement: return $z1 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var334_isEmpty/-813097145=([java.lang.String], boolean), var2774_parseBoolean/746105335=([java.lang.String], boolean)}
; {var2872=org.apache.dubbo.common.Parameters, var3686=r0, var230=r1, var338=null_type, var1741=r2, var1753=z2, var605=r3, var334=org.apache.dubbo.common.utils.StringUtils, var3011=$z0, var2774=java.lang.Boolean, var3441=$z1}
; {org.apache.dubbo.common.Parameters=var2872, r0=var3686, r1=var230, null_type=var338, r2=var1741, z2=var1753, r3=var605, org.apache.dubbo.common.utils.StringUtils=var334, $z0=var3011, java.lang.Boolean=var2774, $z1=var3441}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z2 := @parameter2: boolean;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	return $z1
;block_num 2