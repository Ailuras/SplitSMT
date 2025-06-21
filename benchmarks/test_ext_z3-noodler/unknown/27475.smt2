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

(declare-sort var1369 0)
(declare-sort var2716 0)
(declare-sort var2794 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun updateClassLoaderIfNeed/-1205064022 (var1369) void)
(declare-fun readLength/1927450694 (var1369) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun is/107231720 (var1369) var2716)
(declare-fun read/-661881266 (var2716 (Array Int Int) Int Int) Int)
(declare-fun var2794-init () var2794)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2794 String) void)
(declare-const null-var1369 var1369)
(declare-const null-ClassObject ClassObject)
(declare-const var1238 var1369) ; Statement: r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput 
(assert (not (= var1238 null-var1369)))
(declare-const var3005 ClassObject) ; Statement: r5 := @parameter0: java.lang.Class 
(assert (not (= var3005 null-ClassObject)))
(assert true)
;(assert (updateClassLoaderIfNeed/-1205064022 var1238)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: void updateClassLoaderIfNeed()>() 

(declare-const var1238!1 var1369)
(assert true)
(define-const var905 Int (readLength/1927450694 var1238!1)) ; Statement: i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>() 
(define-const var3140 (Array Int Int) arr-Int-init) ; Statement: r1 = newarray (byte)[i0] 
(define-const var2591 var2716 (is/107231720 var1238!1)) ; Statement: $r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is> 
(assert true)
(define-const var3871 Int (read/-661881266 var2591 var3140 0 var905)) ; Statement: i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0) 
 ; Statement: if i1 == i0 goto $r3 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager fastjson2SecurityManager> 
(assert (not (= var3871 var905))) ; Negate: Cond: i1 == i0  
(define-const var3594 var2794 var2794-init) ; Statement: $r35 = new java.lang.IllegalArgumentException 
(define-const var3322 String String-init) ; Statement: $r34 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3322)) ; Statement: specialinvoke $r34.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3322!1 String)
(assert (= var3322!1 ""))
(assert true)
(define-const var3819 String (append/672562846 var3322!1 "deserialize failed. expected read length: ")) ; Statement: $r28 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: ") 
(declare-const var3322!2 String)
(assert (= var3322!2 (str.++ var3322!1 "deserialize failed. expected read length: ")))
(assert true)
(define-const var704 String (append/-1001720160 var3819 var905)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3819!1 String)
(assert (str.prefixof var3819 var3819!1))
(assert true)
(define-const var745 String (append/672562846 var704 " but actual read: ")) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" but actual read: ") 
(declare-const var704!1 String)
(assert (= var704!1 (str.++ var704 " but actual read: ")))
(assert true)
(define-const var364 String (append/-1001720160 var745 var3871)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var745!1 String)
(assert (str.prefixof var745 var745!1))
(assert true)
(define-const var3451 String (toString/-2075883882 var364)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3594 var3451)) ; Statement: specialinvoke $r35.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r32) 

(declare-const var3594!1 var2794)
(declare-const var3451!1 String)
 ; Statement: throw $r35 
(check-sat)
; {updateClassLoaderIfNeed/-1205064022=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], void), readLength/1927450694=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], int), arr-Int-init=([], byte[]), is/107231720=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], java.io.InputStream), read/-661881266=([java.io.InputStream, byte[], int, int], int), var2794-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1369=org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput, var1238=r0, var3005=r5, var905=i0, var3140=r1, var2716=java.io.InputStream, var2591=$r2, var3871=i1, var2794=java.lang.IllegalArgumentException, var3594=$r35, var3322=$r34, var3819=$r28, var704=$r29, var745=$r30, var364=$r31, var3451=$r32}
; {org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput=var1369, r0=var1238, r5=var3005, i0=var905, r1=var3140, java.io.InputStream=var2716, $r2=var2591, i1=var3871, java.lang.IllegalArgumentException=var2794, $r35=var3594, $r34=var3322, $r28=var3819, $r29=var704, $r30=var745, $r31=var364, $r32=var3451}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput;	r5 := @parameter0: java.lang.Class;	specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: void updateClassLoaderIfNeed()>();	i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>();	r1 = newarray (byte)[i0];	$r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is>;	i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0);	if i1 == i0 goto $r3 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager fastjson2SecurityManager>;	$r35 = new java.lang.IllegalArgumentException;	$r34 = new java.lang.StringBuilder;	specialinvoke $r34.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" but actual read: ");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r35.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r32);	throw $r35
;block_num 2