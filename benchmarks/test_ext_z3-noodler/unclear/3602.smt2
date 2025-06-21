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

(declare-sort var3814 0)
(declare-sort var574 0)
(declare-sort var359 0)
(declare-sort var1180 0)
(declare-sort var487 0)
(declare-sort var2961 0)
(declare-sort var3844 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2961_convertToSplitName/-325941157 (String String) String)
(declare-fun var1180_contains/1636690605 (var1180 var3844) Bool)
(declare-fun cast-from-String-to-var3844 (String) var3844)
(declare-const null-var3814 var3814)
(declare-const null-var574 var574)
(declare-const null-String String)
(declare-const var487-securityKey var1180)
(declare-const var1630 var3814) ; Statement: r5 := @parameter0: java.util.Map 
(assert (not (= var1630 null-var3814)))
(declare-const var3420 var574) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var3420 null-var574)))
(declare-const var3001 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var3001 null-String)))
(define-const var2895 Bool (ite (= 1 0) true false)) ; Statement: z1 = 0 
; split operation: var2401 = var3001.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var2059 var1180 var487-securityKey) ; Statement: $r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey> 
(define-const var2697 Int (get_split_length var3001 "\u005c." -1)) ; Statement: $i0 = lengthof r1 
(define-const var3563 Int (- var2697 1)) ; Statement: $i1 = $i0 - 1 
(define-const var1413 String (get_split_element var3001 "\u005c." -1 var3563)) ; Statement: $r2 = r1[$i1] 
(define-const var2039 String (var2961_convertToSplitName/-325941157 var1413 "-")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-") 
(define-const var3206 Bool (var1180_contains/1636690605 var2059 (cast-from-String-to-var3844 var2039))) ; Statement: $z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3206 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 != 0 goto return 
(assert (not (= (ite var2895 1 0) 0))) ; Cond: z1 != 0 
 ; Statement: return 
(check-sat)
; {var2961_convertToSplitName/-325941157=([java.lang.String, java.lang.String], java.lang.String), var1180_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var3844=([java.lang.String], java.lang.Object)}
; {var3814=java.util.Map, var1630=r5, var574=java.util.Properties, var3420=r6, var3001=r0, var359=null_type, var2895=z1, var2401=r1, var1180=java.util.Set, var487=org.apache.dubbo.common.config.ConfigurationUtils, var2059=$r3, var2697=$i0, var3563=$i1, var1413=$r2, var2961=org.apache.dubbo.common.utils.StringUtils, var2039=$r4, var3844=java.lang.Object, var3206=$z0}
; {java.util.Map=var3814, r5=var1630, java.util.Properties=var574, r6=var3420, r0=var3001, null_type=var359, z1=var2895, r1=var2401, java.util.Set=var1180, org.apache.dubbo.common.config.ConfigurationUtils=var487, $r3=var2059, $i0=var2697, $i1=var3563, $r2=var1413, org.apache.dubbo.common.utils.StringUtils=var2961, $r4=var2039, java.lang.Object=var3844, $z0=var3206}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r5 := @parameter0: java.util.Map;	r6 := @parameter1: java.util.Properties;	r0 := @parameter2: java.lang.String;	z1 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey>;	$i0 = lengthof r1;	$i1 = $i0 - 1;	$r2 = r1[$i1];	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-");	$z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4);	if $z0 == 0 goto (branch);	if z1 != 0 goto return;	return
;block_num 3