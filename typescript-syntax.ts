// 1. Type Annotations: In TypeScript, you can explicitly define the type of variables, function parameters, and return values using type annotations. For example:
let age: number = 30;
function add(a: number, b: number): number {
  return a + b;
}

// 2. Interfaces: TypeScript introduces interfaces, which allow you to define the shape of objects. They are used to enforce a specific structure on objects.
interface Person {
  name: string;
  ages: number;
}

function greet(person: Person) {
  return `Hello, ${person.name}!`;
}

// 3. Enums: Enums in TypeScript allow you to define named constants that represent numeric or string values.
enum Color {
  Red,
  Green,
  Blue,
}
let myColor: Color = Color.Red;

// 4. Type Inference: TypeScript can often infer types based on context, reducing the need for explicit annotations.
let names = 'John';

// 5. Generics: TypeScript supports generics, allowing you to write reusable code that works with different types.
function identity<T>(arg: T): T {
  return arg;
}
let numberResult = identity<number>(5);
let stringResult = identity<string>('Hello');

// 6. Union Types: TypeScript allows you to define a variable or parameter that can have more than one type using union types.
function printLengths(value: string | number): void {
  if (typeof value === 'string') {
    console.log('Length of the string:', value.length);
  } else {
    console.log('Value is a number');
  }
}

// 7. Type Guards: TypeScript includes type guards to narrow down types based on runtime checks.
function printLength(value: string | number): void {
  if (typeof value === 'string') {
    console.log('Length of the string:', value.length);
  } else {
    console.log('Value is a number');
  }
}

// 8. Classes and Constructors: TypeScript supports classes and constructors like JavaScript, but you can also define properties with types and access modifiers.
class Person {
  constructor(public name: string, private age: number) {}
}
let person = new Person('John', 30);
console.log(person.name); 