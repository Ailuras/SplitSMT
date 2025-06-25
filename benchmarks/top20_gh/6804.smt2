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

(declare-sort var590 0)
(declare-sort var1368 0)
(declare-sort var241 0)
(declare-sort var430 0)
(declare-sort var1495 0)
(declare-sort var345 0)
(declare-sort var3025 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var430-init () var430)
(declare-fun <init>/-707998177 (var430) void)
(declare-fun omitComments/-1276310728 (var590) Bool)
(declare-fun store/877702891 (var1495 var1368 String) void)
(declare-fun cast-from-var590-to-var1495 (var590) var1495)
(declare-fun cast-from-var430-to-var1368 (var430) var1368)
(declare-fun toString/-372517094 (var430 var345) String)
(declare-const null-var590 var590)
(declare-const null-var1368 var1368)
(declare-const null-String String)
(declare-const var3025-ISO_8859_1 var345)
(declare-const var590-EOL String)
(declare-const var162 var590) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var162 null-var590)))
(declare-const var29 var1368) ; Statement: r6 := @parameter0: java.io.OutputStream 
(assert (not (= var29 null-var1368)))
(declare-const var3349 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3349 null-String)))
(define-const var2496 var430 var430-init) ; Statement: $r0 = new java.io.ByteArrayOutputStream 
(assert true)
;(assert (<init>/-707998177 var2496)) ; Statement: specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>() 

(declare-const var2496!1 var430)
(define-const var2929 Bool (omitComments/-1276310728 var162)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r13 = r2 
(assert (= (ite var2929 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3799 String var3349) ; Statement: $r13 = r2 
(assert true) ; Non Conditional
(assert true)
;(assert (store/877702891 (cast-from-var590-to-var1495 var162) (cast-from-var430-to-var1368 var2496!1) var3799)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13) 

(declare-const var162!1 var590)
(declare-const var2496!2 var430)
(declare-const var3799!1 String)
(define-const var3500 var345 var3025-ISO_8859_1) ; Statement: $r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1> 
(assert true)
(define-const var95 String (toString/-372517094 var2496!2 var3500)) ; Statement: $r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3) 
(define-const var3176 String var590-EOL) ; Statement: $r4 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var1010 = var95.split(var3176) ; Statement: $r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4) 
(define-const var289 Int (get_split_length var95 var3176 -1)) ; Statement: $i0 = lengthof $r12 
(define-const var3346 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var3346 var289)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var430-init=([], java.io.ByteArrayOutputStream), <init>/-707998177=([java.io.ByteArrayOutputStream], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/877702891=([java.util.Properties, java.io.OutputStream, java.lang.String], void), cast-from-var590-to-var1495=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var430-to-var1368=([java.io.ByteArrayOutputStream], java.io.OutputStream), toString/-372517094=([java.io.ByteArrayOutputStream, java.nio.charset.Charset], java.lang.String)}
; {var590=org.springframework.core.SortedProperties, var162=r1, var1368=java.io.OutputStream, var29=r6, var3349=r2, var241=null_type, var430=java.io.ByteArrayOutputStream, var2496=$r0, var2929=$z0, var3799=$r13, var1495=java.util.Properties, var345=java.nio.charset.Charset, var3025=java.nio.charset.StandardCharsets, var3500=$r3, var95=$r11, var3176=$r4, var1010=$r12, var289=$i0, var3346=i1}
; {org.springframework.core.SortedProperties=var590, r1=var162, java.io.OutputStream=var1368, r6=var29, r2=var3349, null_type=var241, java.io.ByteArrayOutputStream=var430, $r0=var2496, $z0=var2929, $r13=var3799, java.util.Properties=var1495, java.nio.charset.Charset=var345, java.nio.charset.StandardCharsets=var3025, $r3=var3500, $r11=var95, $r4=var3176, $r12=var1010, $i0=var289, i1=var3346}
;seq <java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r6 := @parameter0: java.io.OutputStream;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.ByteArrayOutputStream;	specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r13 = r2;	$r13 = r2;	specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13);	$r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1>;	$r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3);	$r4 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4);	$i0 = lengthof $r12;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5