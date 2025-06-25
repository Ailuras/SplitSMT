(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3441 0)
(declare-sort var1603 0)
(declare-sort var2784 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var3441 var3441)
(declare-const null-String String)
(declare-const var2784-SERVICE_NAME_SEPARATOR String)
(declare-const var3094 var3441) ; Statement: r4 := @parameter0: java.util.List 
(assert (not (= var3094 null-var3441)))
(declare-const var1339 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var1339 null-String)))
(declare-const var2970 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var2970 null-String)))
(declare-const var515 String) ; Statement: r10 := @parameter3: java.lang.String 
(assert (not (= var515 null-String)))
(declare-const var1165 String) ; Statement: r0 := @parameter4: java.lang.String 
(assert (not (= var1165 null-String)))
(define-const var3656 String var2784-SERVICE_NAME_SEPARATOR) ; Statement: $r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR> 
(define-const var3504 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var701 = var1165.split(var3656, var3504) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2) 
(define-const var2234 Int (get_split_length var1165 var3656 var3504)) ; Statement: i0 = lengthof r2 
 ; Statement: if i0 == 4 goto r3 = r2[0] 
(assert (not (= var2234 4))) ; Negate: Cond: i0 == 4  
 ; Statement: return 0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var3441=java.util.List, var3094=r4, var1339=r6, var1603=null_type, var2970=r8, var515=r10, var1165=r0, var2784=org.apache.dubbo.registry.nacos.NacosRegistry, var3656=$r1, var3504=$i2, var701=r2, var2234=i0}
; {java.util.List=var3441, r4=var3094, r6=var1339, null_type=var1603, r8=var2970, r10=var515, r0=var1165, org.apache.dubbo.registry.nacos.NacosRegistry=var2784, $r1=var3656, $i2=var3504, r2=var701, i0=var2234}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r4 := @parameter0: java.util.List;	r6 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	r10 := @parameter3: java.lang.String;	r0 := @parameter4: java.lang.String;	$r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR>;	$i2 = (int) -1;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2);	i0 = lengthof r2;	if i0 == 4 goto r3 = r2[0];	return 0
;block_num 2