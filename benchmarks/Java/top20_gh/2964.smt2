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

(declare-sort var638 0)
(declare-sort var2956 0)
(declare-sort var3785 0)
(declare-sort var1307 0)
(declare-sort var1661 0)
(declare-sort var3770 0)
(declare-sort var1115 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3770_convertToSplitName/-325941157 (String String) String)
(declare-fun var1307_contains/1636690605 (var1307 var1115) Bool)
(declare-fun cast-from-String-to-var1115 (String) var1115)
(declare-const null-var638 var638)
(declare-const null-var2956 var2956)
(declare-const null-String String)
(declare-const var1661-securityKey var1307)
(declare-const var2989 var638) ; Statement: r5 := @parameter0: java.util.Map 
(assert (not (= var2989 null-var638)))
(declare-const var2968 var2956) ; Statement: r6 := @parameter1: java.util.Properties 
(assert (not (= var2968 null-var2956)))
(declare-const var2779 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var2779 null-String)))
(define-const var677 Bool (ite (= 1 0) true false)) ; Statement: z1 = 0 
; split operation: var2929 = var2779.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var331 var1307 var1661-securityKey) ; Statement: $r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey> 
(define-const var3375 Int (get_split_length var2779 "\u005c." -1)) ; Statement: $i0 = lengthof r1 
(define-const var3941 Int (- var3375 1)) ; Statement: $i1 = $i0 - 1 
(define-const var2055 String (get_split_element var2779 "\u005c." -1 var3941)) ; Statement: $r2 = r1[$i1] 
(define-const var2976 String (var3770_convertToSplitName/-325941157 var2055 "-")) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-") 
(define-const var3693 Bool (var1307_contains/1636690605 var331 (cast-from-String-to-var1115 var2976))) ; Statement: $z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3693 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 != 0 goto return 
(assert (not (= (ite var677 1 0) 0))) ; Cond: z1 != 0 
 ; Statement: return 
(check-sat)
; {var3770_convertToSplitName/-325941157=([java.lang.String, java.lang.String], java.lang.String), var1307_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var1115=([java.lang.String], java.lang.Object)}
; {var638=java.util.Map, var2989=r5, var2956=java.util.Properties, var2968=r6, var2779=r0, var3785=null_type, var677=z1, var2929=r1, var1307=java.util.Set, var1661=org.apache.dubbo.common.config.ConfigurationUtils, var331=$r3, var3375=$i0, var3941=$i1, var2055=$r2, var3770=org.apache.dubbo.common.utils.StringUtils, var2976=$r4, var1115=java.lang.Object, var3693=$z0}
; {java.util.Map=var638, r5=var2989, java.util.Properties=var2956, r6=var2968, r0=var2779, null_type=var3785, z1=var677, r1=var2929, java.util.Set=var1307, org.apache.dubbo.common.config.ConfigurationUtils=var1661, $r3=var331, $i0=var3375, $i1=var3941, $r2=var2055, org.apache.dubbo.common.utils.StringUtils=var3770, $r4=var2976, java.lang.Object=var1115, $z0=var3693}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r5 := @parameter0: java.util.Map;	r6 := @parameter1: java.util.Properties;	r0 := @parameter2: java.lang.String;	z1 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$r3 = <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set securityKey>;	$i0 = lengthof r1;	$i1 = $i0 - 1;	$r2 = r1[$i1];	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String convertToSplitName(java.lang.String,java.lang.String)>($r2, "-");	$z0 = interfaceinvoke $r3.<java.util.Set: boolean contains(java.lang.Object)>($r4);	if $z0 == 0 goto (branch);	if z1 != 0 goto return;	return
;block_num 3