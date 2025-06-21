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

(declare-sort var1913 0)
(declare-sort var1074 0)
(declare-sort var3604 0)
(declare-sort var2048 0)
(declare-sort var1679 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3604_getDesc/1511409214 (var1074) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun addConstructor/1313030879 (var1913 String) var1913)
(declare-fun mCopyConstructors/-2046325769 (var1913) var2048)
(declare-fun var2048_put/1464166817 (var2048 var1679 var1679) var1679)
(declare-fun cast-from-String-to-var1679 (String) var1679)
(declare-fun cast-from-var1074-to-var1679 (var1074) var1679)
(declare-const null-var1913 var1913)
(declare-const null-var1074 var1074)
(declare-const null-var2048 var2048)
(declare-const var1101 var1913) ; Statement: r2 := @this: org.apache.dubbo.common.bytecode.ClassGenerator 
(assert (not (= var1101 null-var1913)))
(declare-const var2098 var1074) ; Statement: r0 := @parameter0: java.lang.reflect.Constructor 
(assert (not (= var2098 null-var1074)))
(define-const var3469 String (var3604_getDesc/1511409214 var2098)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.reflect.Constructor)>(r0) 
(define-const var3906 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3906)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3906!1 String)
(assert (= var3906!1 ""))
(assert true)
(define-const var77 String (append/672562846 var3906!1 ":")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var3906!2 String)
(assert (= var3906!2 (str.++ var3906!1 ":")))
(assert true)
(define-const var2329 String (append/672562846 var77 var3469)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var77!1 String)
(assert (= var77!1 (str.++ var77 var3469)))
(assert true)
(define-const var1233 String (toString/-2075883882 var2329)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (addConstructor/1313030879 var1101 var1233)) ; Statement: virtualinvoke r2.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addConstructor(java.lang.String)>($r6) 

(declare-const var1101!1 var1913)
(declare-const var1233!1 String)
(define-const var1577 var2048 (mCopyConstructors/-2046325769 var1101!1)) ; Statement: $r7 = r2.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyConstructors> 
 ; Statement: if $r7 != null goto $r8 = r2.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyConstructors> 
(assert (not (= var1577 null-var2048))) ; Cond: $r7 != null 
(define-const var369 var2048 (mCopyConstructors/-2046325769 var1101!1)) ; Statement: $r8 = r2.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyConstructors> 
;(assert (var2048_put/1464166817 var369 (cast-from-String-to-var1679 var3469) (cast-from-var1074-to-var1679 var2098))) ; Statement: interfaceinvoke $r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r0) 

(declare-const var369!1 var2048)
(declare-const var3469!1 String)
(declare-const var2098!1 var1074)
 ; Statement: return r2 
(check-sat)
; {var3604_getDesc/1511409214=([java.lang.reflect.Constructor], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), addConstructor/1313030879=([org.apache.dubbo.common.bytecode.ClassGenerator, java.lang.String], org.apache.dubbo.common.bytecode.ClassGenerator), mCopyConstructors/-2046325769=([org.apache.dubbo.common.bytecode.ClassGenerator], java.util.Map), var2048_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1679=([java.lang.String], java.lang.Object), cast-from-var1074-to-var1679=([java.lang.reflect.Constructor], java.lang.Object)}
; {var1913=org.apache.dubbo.common.bytecode.ClassGenerator, var1101=r2, var1074=java.lang.reflect.Constructor, var2098=r0, var3604=org.apache.dubbo.common.utils.ReflectUtils, var3469=r1, var3906=$r3, var77=$r4, var2329=$r5, var1233=$r6, var2048=java.util.Map, var1577=$r7, var369=$r8, var1679=java.lang.Object}
; {org.apache.dubbo.common.bytecode.ClassGenerator=var1913, r2=var1101, java.lang.reflect.Constructor=var1074, r0=var2098, org.apache.dubbo.common.utils.ReflectUtils=var3604, r1=var3469, $r3=var3906, $r4=var77, $r5=var2329, $r6=var1233, java.util.Map=var2048, $r7=var1577, $r8=var369, java.lang.Object=var1679}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.common.bytecode.ClassGenerator;	r0 := @parameter0: java.lang.reflect.Constructor;	r1 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.reflect.Constructor)>(r0);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r2.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addConstructor(java.lang.String)>($r6);	$r7 = r2.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyConstructors>;	if $r7 != null goto $r8 = r2.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyConstructors>;	$r8 = r2.<org.apache.dubbo.common.bytecode.ClassGenerator: java.util.Map mCopyConstructors>;	interfaceinvoke $r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r0);	return r2
;block_num 2