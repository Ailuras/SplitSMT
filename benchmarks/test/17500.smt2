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

(declare-sort var1729 0)
(declare-sort var254 0)
(declare-sort var1655 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1729 var1729)
(declare-const null-String String)
(declare-const var1655-SERVICE_NAME_SEPARATOR String)
(declare-const var2415 var1729) ; Statement: r4 := @parameter0: java.util.List 
(assert (not (= var2415 null-var1729)))
(declare-const var2177 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var2177 null-String)))
(declare-const var3094 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var3094 null-String)))
(declare-const var3653 String) ; Statement: r10 := @parameter3: java.lang.String 
(assert (not (= var3653 null-String)))
(declare-const var834 String) ; Statement: r0 := @parameter4: java.lang.String 
(assert (not (= var834 null-String)))
(define-const var1735 String var1655-SERVICE_NAME_SEPARATOR) ; Statement: $r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR> 
(define-const var3887 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var845 = var834.split(var1735, var3887) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2) 
(define-const var1399 Int (get_split_length var834 var1735 var3887)) ; Statement: i0 = lengthof r2 
 ; Statement: if i0 == 4 goto r3 = r2[0] 
(assert (not (= var1399 4))) ; Negate: Cond: i0 == 4  
 ; Statement: return 0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var1729=java.util.List, var2415=r4, var2177=r6, var254=null_type, var3094=r8, var3653=r10, var834=r0, var1655=org.apache.dubbo.registry.nacos.NacosRegistry, var1735=$r1, var3887=$i2, var845=r2, var1399=i0}
; {java.util.List=var1729, r4=var2415, r6=var2177, null_type=var254, r8=var3094, r10=var3653, r0=var834, org.apache.dubbo.registry.nacos.NacosRegistry=var1655, $r1=var1735, $i2=var3887, r2=var845, i0=var1399}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r4 := @parameter0: java.util.List;	r6 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	r10 := @parameter3: java.lang.String;	r0 := @parameter4: java.lang.String;	$r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR>;	$i2 = (int) -1;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2);	i0 = lengthof r2;	if i0 == 4 goto r3 = r2[0];	return 0
;block_num 2