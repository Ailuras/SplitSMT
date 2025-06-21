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

(declare-sort var3363 0)
(declare-sort var1791 0)
(declare-sort var2925 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var3363 String String) String)
(declare-fun var2925_isEmpty/-813097145 (String) Bool)
(declare-const null-var3363 var3363)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3818 var3363) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3818 null-var3363)))
(declare-const var3380 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3380 null-String)))
(declare-const var1682 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1682 null-String)))
(declare-const var3342 Bool) ; Statement: z2 := @parameter2: boolean 
(assert (not (= var3342 null-Bool)))
(assert true)
(define-const var1989 String (getMethodParameter/2069355293 var3818 var3380 var1682)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1885 Bool (var2925_isEmpty/-813097145 var1989)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (not (= (ite var1885 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return z2 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var2925_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3363=org.apache.dubbo.common.Parameters, var3818=r0, var3380=r1, var1791=null_type, var1682=r2, var3342=z2, var1989=r3, var2925=org.apache.dubbo.common.utils.StringUtils, var1885=$z0}
; {org.apache.dubbo.common.Parameters=var3363, r0=var3818, r1=var3380, null_type=var1791, r2=var1682, z2=var3342, r3=var1989, org.apache.dubbo.common.utils.StringUtils=var2925, $z0=var1885}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z2 := @parameter2: boolean;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	return z2
;block_num 2