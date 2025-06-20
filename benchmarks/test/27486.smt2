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

(declare-sort var170 0)
(declare-sort var1294 0)
(declare-sort var3422 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun updateClassLoaderIfNeed/-1205064022 (var170) void)
(declare-fun readLength/1927450694 (var170) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun is/107231720 (var170) var1294)
(declare-fun read/-661881266 (var1294 (Array Int Int) Int Int) Int)
(declare-fun var3422-init () var3422)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3422 String) void)
(declare-const null-var170 var170)
(declare-const null-ClassObject ClassObject)
(declare-const var2396 var170) ; Statement: r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput 
(assert (not (= var2396 null-var170)))
(declare-const var265 ClassObject) ; Statement: r5 := @parameter0: java.lang.Class 
(assert (not (= var265 null-ClassObject)))
(declare-const var1718 ClassObject) ; Statement: r33 := @parameter1: java.lang.reflect.Type 
(assert (not (= var1718 null-ClassObject)))
(assert true)
;(assert (updateClassLoaderIfNeed/-1205064022 var2396)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: void updateClassLoaderIfNeed()>() 

(declare-const var2396!1 var170)
(assert true)
(define-const var3261 Int (readLength/1927450694 var2396!1)) ; Statement: i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>() 
(define-const var3464 (Array Int Int) arr-Int-init) ; Statement: r1 = newarray (byte)[i0] 
(define-const var875 var1294 (is/107231720 var2396!1)) ; Statement: $r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is> 
(assert true)
(define-const var3693 Int (read/-661881266 var875 var3464 0 var3261)) ; Statement: i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0) 
 ; Statement: if i1 == i0 goto $r3 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager fastjson2SecurityManager> 
(assert (not (= var3693 var3261))) ; Negate: Cond: i1 == i0  
(define-const var3087 var3422 var3422-init) ; Statement: $r36 = new java.lang.IllegalArgumentException 
(define-const var3221 String String-init) ; Statement: $r35 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3221)) ; Statement: specialinvoke $r35.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3221!1 String)
(assert (= var3221!1 ""))
(assert true)
(define-const var528 String (append/672562846 var3221!1 "deserialize failed. expected read length: ")) ; Statement: $r28 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: ") 
(declare-const var3221!2 String)
(assert (= var3221!2 (str.++ var3221!1 "deserialize failed. expected read length: ")))
(assert true)
(define-const var1644 String (append/-1001720160 var528 var3261)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var528!1 String)
(assert (str.prefixof var528 var528!1))
(assert true)
(define-const var1778 String (append/672562846 var1644 " but actual read: ")) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" but actual read: ") 
(declare-const var1644!1 String)
(assert (= var1644!1 (str.++ var1644 " but actual read: ")))
(assert true)
(define-const var303 String (append/-1001720160 var1778 var3693)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var1778!1 String)
(assert (str.prefixof var1778 var1778!1))
(assert true)
(define-const var3328 String (toString/-2075883882 var303)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3087 var3328)) ; Statement: specialinvoke $r36.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r32) 

(declare-const var3087!1 var3422)
(declare-const var3328!1 String)
 ; Statement: throw $r36 
(check-sat)
; {updateClassLoaderIfNeed/-1205064022=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], void), readLength/1927450694=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], int), arr-Int-init=([], byte[]), is/107231720=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], java.io.InputStream), read/-661881266=([java.io.InputStream, byte[], int, int], int), var3422-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var170=org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput, var2396=r0, var265=r5, var1718=r33, var3261=i0, var3464=r1, var1294=java.io.InputStream, var875=$r2, var3693=i1, var3422=java.lang.IllegalArgumentException, var3087=$r36, var3221=$r35, var528=$r28, var1644=$r29, var1778=$r30, var303=$r31, var3328=$r32}
; {org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput=var170, r0=var2396, r5=var265, r33=var1718, i0=var3261, r1=var3464, java.io.InputStream=var1294, $r2=var875, i1=var3693, java.lang.IllegalArgumentException=var3422, $r36=var3087, $r35=var3221, $r28=var528, $r29=var1644, $r30=var1778, $r31=var303, $r32=var3328}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput;	r5 := @parameter0: java.lang.Class;	r33 := @parameter1: java.lang.reflect.Type;	specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: void updateClassLoaderIfNeed()>();	i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>();	r1 = newarray (byte)[i0];	$r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is>;	i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0);	if i1 == i0 goto $r3 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager fastjson2SecurityManager>;	$r36 = new java.lang.IllegalArgumentException;	$r35 = new java.lang.StringBuilder;	specialinvoke $r35.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" but actual read: ");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r36.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r32);	throw $r36
;block_num 2