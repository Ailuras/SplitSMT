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

(declare-sort var1580 0)
(declare-sort var3895 0)
(declare-sort var3461 0)
(declare-sort var3328 0)
(declare-sort var1206 0)
(declare-sort var2929 0)
(declare-sort var1096 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3328-init () var3328)
(declare-fun <init>/-707998177 (var3328) void)
(declare-fun omitComments/-1276310728 (var1580) Bool)
(declare-fun store/877702891 (var1206 var3895 String) void)
(declare-fun cast-from-var1580-to-var1206 (var1580) var1206)
(declare-fun cast-from-var3328-to-var3895 (var3328) var3895)
(declare-fun toString/-372517094 (var3328 var2929) String)
(declare-const null-var1580 var1580)
(declare-const null-var3895 var3895)
(declare-const null-String String)
(declare-const var1096-ISO_8859_1 var2929)
(declare-const var1580-EOL String)
(declare-const var1332 var1580) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var1332 null-var1580)))
(declare-const var3469 var3895) ; Statement: r6 := @parameter0: java.io.OutputStream 
(assert (not (= var3469 null-var3895)))
(declare-const var2020 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2020 null-String)))
(define-const var1715 var3328 var3328-init) ; Statement: $r0 = new java.io.ByteArrayOutputStream 
(assert true)
;(assert (<init>/-707998177 var1715)) ; Statement: specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>() 

(declare-const var1715!1 var3328)
(define-const var2025 Bool (omitComments/-1276310728 var1332)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r13 = r2 
(assert (not (= (ite var2025 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3636 String null-String) ; Statement: $r13 = null 
 ; Statement: goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13)] 
(assert true) ; Non Conditional
(assert true)
;(assert (store/877702891 (cast-from-var1580-to-var1206 var1332) (cast-from-var3328-to-var3895 var1715!1) var3636)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13) 

(declare-const var1332!1 var1580)
(declare-const var1715!2 var3328)
(declare-const var3636!1 String)
(define-const var3343 var2929 var1096-ISO_8859_1) ; Statement: $r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1> 
(assert true)
(define-const var3778 String (toString/-372517094 var1715!2 var3343)) ; Statement: $r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3) 
(define-const var2881 String var1580-EOL) ; Statement: $r4 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var3805 = var3778.split(var2881) ; Statement: $r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4) 
(define-const var3374 Int (get_split_length var3778 var2881 -1)) ; Statement: $i0 = lengthof $r12 
(define-const var2089 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var2089 var3374)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var3328-init=([], java.io.ByteArrayOutputStream), <init>/-707998177=([java.io.ByteArrayOutputStream], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/877702891=([java.util.Properties, java.io.OutputStream, java.lang.String], void), cast-from-var1580-to-var1206=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var3328-to-var3895=([java.io.ByteArrayOutputStream], java.io.OutputStream), toString/-372517094=([java.io.ByteArrayOutputStream, java.nio.charset.Charset], java.lang.String)}
; {var1580=org.springframework.core.SortedProperties, var1332=r1, var3895=java.io.OutputStream, var3469=r6, var2020=r2, var3461=null_type, var3328=java.io.ByteArrayOutputStream, var1715=$r0, var2025=$z0, var3636=$r13, var1206=java.util.Properties, var2929=java.nio.charset.Charset, var1096=java.nio.charset.StandardCharsets, var3343=$r3, var3778=$r11, var2881=$r4, var3805=$r12, var3374=$i0, var2089=i1}
; {org.springframework.core.SortedProperties=var1580, r1=var1332, java.io.OutputStream=var3895, r6=var3469, r2=var2020, null_type=var3461, java.io.ByteArrayOutputStream=var3328, $r0=var1715, $z0=var2025, $r13=var3636, java.util.Properties=var1206, java.nio.charset.Charset=var2929, java.nio.charset.StandardCharsets=var1096, $r3=var3343, $r11=var3778, $r4=var2881, $r12=var3805, $i0=var3374, i1=var2089}
;seq <java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r6 := @parameter0: java.io.OutputStream;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.ByteArrayOutputStream;	specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r13 = r2;	$r13 = null;	goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13)];	specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13);	$r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1>;	$r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3);	$r4 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4);	$i0 = lengthof $r12;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5