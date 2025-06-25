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

(declare-sort var3378 0)
(declare-sort var920 0)
(declare-sort var343 0)
(declare-sort var3763 0)
(declare-sort var2024 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var343_newHashMap/701256970 () var920)
(declare-fun var920_put/1464166817 (var920 var3763 var3763) var3763)
(declare-fun cast-from-String-to-var3763 (String) var3763)
(declare-fun var2024-init () var2024)
(declare-fun <init>/379364885 (var2024) void)
(declare-fun var920_get/1088891777 (var920 var3763) var3763)
(declare-fun cast-from-var3763-to-String (var3763) String)
(declare-fun setWord/1927702860 (var2024 String) void)
(declare-fun setLemma/-2044772538 (var2024 String) void)
(declare-fun setTag/-492450796 (var2024 String) void)
(declare-fun setValue/-1305364003 (var2024 String) void)
(declare-fun setOriginalText/-1052378824 (var2024 String) void)
(declare-const null-String String)
(declare-const var3830 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3830 null-String)))
(assert true)
(define-const var763 Int (length/-134980193 var3830)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var3490 Int (- var763 1)) ; Statement: $i1 = $i0 - 1 
(assert (not (and true (and (>= 1 0) (>= (str.len var3830) var3490) (>= var3490 1)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var343_newHashMap/701256970=([], java.util.Map), var920_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3763=([java.lang.String], java.lang.Object), var2024-init=([], edu.stanford.nlp.ling.IndexedWord), <init>/379364885=([edu.stanford.nlp.ling.IndexedWord], void), var920_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3763-to-String=([java.lang.Object], java.lang.String), setWord/1927702860=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setLemma/-2044772538=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setTag/-492450796=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setValue/-1305364003=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setOriginalText/-1052378824=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void)}
; {var3830=r0, var3378=null_type, var763=$i0, var3490=$i1, var1041=r1, var1908=r2, var920=java.util.Map, var343=edu.stanford.nlp.util.Generics, var3243=r3, var2966=i2, var1731=i4, var2278=r15, var1922=r16, var1032=r17, var1143=r18, var3063=$i3, var3763=java.lang.Object, var2024=edu.stanford.nlp.ling.IndexedWord, var18=$r4, var3811=$r5, var1925=$r6, var645=$r7, var2819=$r8, var3066=$r9, var3055=$r10, var287=$r11, var52=$r12, var1419=$r13, var3485=$r14}
; {r0=var3830, null_type=var3378, $i0=var763, $i1=var3490, r1=var1041, r2=var1908, java.util.Map=var920, edu.stanford.nlp.util.Generics=var343, r3=var3243, i2=var2966, i4=var1731, r15=var2278, r16=var1922, r17=var1032, r18=var1143, $i3=var3063, java.lang.Object=var3763, edu.stanford.nlp.ling.IndexedWord=var2024, $r4=var18, $r5=var3811, $r6=var1925, $r7=var645, $r8=var2819, $r9=var3066, $r10=var3055, $r11=var287, $r12=var52, $r13=var1419, $r14=var3485}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i2 = lengthof r2;	i4 = 0;	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	$r4 = new edu.stanford.nlp.ling.IndexedWord;	specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>();	$r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word");	$r6 = (java.lang.String) $r5;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6);	$r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma");	$r8 = (java.lang.String) $r7;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8);	$r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS");	$r10 = (java.lang.String) $r9;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10);	$r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value");	$r12 = (java.lang.String) $r11;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12);	$r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current");	$r14 = (java.lang.String) $r13;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14);	return $r4
;block_num 6