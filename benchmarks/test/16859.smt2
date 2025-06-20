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

(declare-sort var3709 0)
(declare-sort var1834 0)
(declare-sort var2698 0)
(declare-sort var107 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1834_getSerializationById/-696791859 (Int) var3709)
(declare-fun var2698-init () var2698)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var107) String)
(declare-fun cast-from-Int-to-var107 (Int) var107)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1557872005 (var2698 String) void)
(declare-const null-Int Int)
(declare-const null-var3709 var3709)
(declare-const var1380 Int) ; Statement: r0 := @parameter0: java.lang.Byte 
(assert (not (= var1380 null-Int)))
(define-const var2442 var3709 (var1834_getSerializationById/-696791859 var1380)) ; Statement: r1 = staticinvoke <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.serialize.Serialization getSerializationById(java.lang.Byte)>(r0) 
 ; Statement: if r1 != null goto return r1 
(assert (not (not (= var2442 null-var3709)))) ; Negate: Cond: r1 != null  
(define-const var866 var2698 var2698-init) ; Statement: $r2 = new java.io.IOException 
(define-const var31 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var31)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var31!1 String)
(assert (= var31!1 ""))
(assert true)
(define-const var2658 String (append/672562846 var31!1 "Unrecognized serialize type from consumer: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unrecognized serialize type from consumer: ") 
(declare-const var31!2 String)
(assert (= var31!2 (str.++ var31!1 "Unrecognized serialize type from consumer: ")))
(assert true)
(define-const var218 String (append/-1031950772 var2658 (cast-from-Int-to-var107 var1380))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2658!1 String)
(assert (str.prefixof var2658 var2658!1))
(assert true)
(define-const var470 String (toString/-2075883882 var218)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1557872005 var866 var470)) ; Statement: specialinvoke $r2.<java.io.IOException: void <init>(java.lang.String)>($r6) 

(declare-const var866!1 var2698)
(declare-const var470!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var1834_getSerializationById/-696791859=([java.lang.Byte], org.apache.dubbo.common.serialize.Serialization), var2698-init=([], java.io.IOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-Int-to-var107=([java.lang.Byte], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var1380=r0, var3709=org.apache.dubbo.common.serialize.Serialization, var1834=org.apache.dubbo.remoting.transport.CodecSupport, var2442=r1, var2698=java.io.IOException, var866=$r2, var31=$r3, var2658=$r4, var107=java.lang.Object, var218=$r5, var470=$r6}
; {r0=var1380, org.apache.dubbo.common.serialize.Serialization=var3709, org.apache.dubbo.remoting.transport.CodecSupport=var1834, r1=var2442, java.io.IOException=var2698, $r2=var866, $r3=var31, $r4=var2658, java.lang.Object=var107, $r5=var218, $r6=var470}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Byte;	r1 = staticinvoke <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.serialize.Serialization getSerializationById(java.lang.Byte)>(r0);	if r1 != null goto return r1;	$r2 = new java.io.IOException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unrecognized serialize type from consumer: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.io.IOException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2