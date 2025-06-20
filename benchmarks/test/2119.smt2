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

(declare-sort var2618 0)
(declare-sort var2808 0)
(declare-sort var2154 0)
(declare-sort var3515 0)
(declare-sort var1148 0)
(declare-sort var608 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3515_getDescWithoutMethodName/1882021899 (var2154) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun addMethod/-429150454 (var2618 String) var2618)
(declare-fun mCopyMethods/-2046325769 (var2618) var1148)
(declare-fun var1148_put/1464166817 (var1148 var608 var608) var608)
(declare-fun cast-from-String-to-var608 (String) var608)
(declare-fun cast-from-var2154-to-var608 (var2154) var608)
(declare-const null-var2618 var2618)
(declare-const null-String String)
(declare-const null-var2154 var2154)
(declare-const null-var1148 var1148)
(declare-const var163 var2618) ; Statement: r7 := @this: org.apache.dubbo.common.bytecode.ClassGenerator 
(assert (not (= var163 null-var2618)))
(declare-const var2364 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2364 null-String)))
(declare-const var921 var2154) ; Statement: r2 := @parameter1: java.lang.reflect.Method 
(assert (not (= var921 null-var2154)))
(define-const var628 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var628)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var628!1 String)
(assert (= var628!1 ""))
(assert true)
(define-const var2348 String (append/672562846 var628!1 var2364)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var628!2 String)
(assert (= var628!2 (str.++ var628!1 var2364)))
(define-const var2247 String (var3515_getDescWithoutMethodName/1882021899 var921)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDescWithoutMethodName(java.lang.reflect.Method)>(r2) 
(assert true)
(define-const var2875 String (append/672562846 var2348 var2247)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2348!1 String)
(assert (= var2348!1 (str.++ var2348 var2247)))
(assert true)
(define-const var1485 String (toString/-2075883882 var2875)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1570 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1570)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1570!1 String)
(assert (= var1570!1 ""))
(assert true)
(define-const var3789 String (append/-1166366385 var1570!1 58)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1570!2 String)
(assert (str.prefixof var1570!1 var1570!2))
(assert true)
(define-const var1116 String (append/672562846 var3789 var1485)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6) 
(declare-const var3789!1 String)
(assert (= var3789!1 (str.++ var3789 var1485)))
(assert true)
(define-const var3630 String (toString/-2075883882 var1116)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (addMethod/-429150454 var163 var3630)) ; Statement: virtualinvoke r7.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addMethod(java.lang.String)>($r11) 

(declare-const var163!1 var2618)
(declare-const var3630!1 String)
(define-const var649 var1148 (mCopyMethods/-2046325769 var163!1)) ; Statement: $r12 = r7.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyMethods> 
 ; Statement: if $r12 != null goto $r13 = r7.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyMethods> 
(assert (not (= var649 null-var1148))) ; Cond: $r12 != null 
(define-const var2711 var1148 (mCopyMethods/-2046325769 var163!1)) ; Statement: $r13 = r7.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyMethods> 
;(assert (var1148_put/1464166817 var2711 (cast-from-String-to-var608 var1485) (cast-from-var2154-to-var608 var921))) ; Statement: interfaceinvoke $r13.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r6, r2) 

(declare-const var2711!1 var1148)
(declare-const var1485!1 String)
(declare-const var921!1 var2154)
 ; Statement: return r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3515_getDescWithoutMethodName/1882021899=([java.lang.reflect.Method], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), addMethod/-429150454=([org.apache.dubbo.common.bytecode.ClassGenerator, java.lang.String], org.apache.dubbo.common.bytecode.ClassGenerator), mCopyMethods/-2046325769=([org.apache.dubbo.common.bytecode.ClassGenerator], java.util.Map), var1148_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var608=([java.lang.String], java.lang.Object), cast-from-var2154-to-var608=([java.lang.reflect.Method], java.lang.Object)}
; {var2618=org.apache.dubbo.common.bytecode.ClassGenerator, var163=r7, var2364=r1, var2808=null_type, var2154=java.lang.reflect.Method, var921=r2, var628=$r0, var2348=$r4, var3515=org.apache.dubbo.common.utils.ReflectUtils, var2247=$r3, var2875=$r5, var1485=r6, var1570=$r8, var3789=$r9, var1116=$r10, var3630=$r11, var1148=java.util.Map, var649=$r12, var2711=$r13, var608=java.lang.Object}
; {org.apache.dubbo.common.bytecode.ClassGenerator=var2618, r7=var163, r1=var2364, null_type=var2808, java.lang.reflect.Method=var2154, r2=var921, $r0=var628, $r4=var2348, org.apache.dubbo.common.utils.ReflectUtils=var3515, $r3=var2247, $r5=var2875, r6=var1485, $r8=var1570, $r9=var3789, $r10=var1116, $r11=var3630, java.util.Map=var1148, $r12=var649, $r13=var2711, java.lang.Object=var608}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1}
;stmts r7 := @this: org.apache.dubbo.common.bytecode.ClassGenerator;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.reflect.Method;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDescWithoutMethodName(java.lang.reflect.Method)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r7.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addMethod(java.lang.String)>($r11);	$r12 = r7.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyMethods>;	if $r12 != null goto $r13 = r7.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyMethods>;	$r13 = r7.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyMethods>;	interfaceinvoke $r13.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r6, r2);	return r7
;block_num 2